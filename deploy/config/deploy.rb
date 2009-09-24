role :files, "10.10.1.21", :user => 'hudson'

set :application, "studio" # Which project are we pushing (this controls folder name used from Hudson and s3)
set :branch, "master" # which branch was it built on?
set :bucket_name, 'download.aptana.org' # Which bucket are we pushing it to?
set :containing_folder_name, "#{application}"
set :bucket_path_prefix, "tools/radrails/plugin/update"
set :build_artifact_path, "/var/update-site/update/#{branch}" # Where does it live on the build file server?
set :compressed_filename, "#{application}.tar.gz"

namespace :deploy do
  # TODO I think I can just grab the zip file that's already in the artifacts and download that only!
  desc "Compress the contents of the build artifacts to speed up downloading them locally"
  task :compress, :roles => :files do
    sudo "tar -pczf /var/#{compressed_filename} -C #{build_artifact_path} #{application}"
  end
  
  desc "Download the compressed build artifacts"
  task :grab, :roles => :files do
    get("/var/#{compressed_filename}", compressed_filename)
    sudo "rm -f /var/#{compressed_filename}"
  end
  
  desc "Uncompress the downloaded build artifacts"
  task :uncompress do
    run_locally("tar -xvzf #{compressed_filename}")
    run_locally("rm -f #{compressed_filename}")
  end
  
  # Used in our "legacy" update scheme where we assume unique version numbers to releases and then do apache redirects
  #  desc "Extract versio number and set up so we store under the version name as folder in S3"
  #  task :extract_version, :depends => [:uncompress] do
  #    value = Dir.glob("#{application}/*-*.zip")
  #    set :containing_folder_name, value[0].match(/.+(\d+\.\d+\.\d+\.\d+).+/)[1]
  #    set :bucket_path_prefix, "#{bucket_path_prefix}/#{application}"
  #  end
  
  desc "Change the directory name to what we'll use on S3"
  task :rename do
    FileUtils.mv(application, containing_folder_name) if application != containing_folder_name
  end
  
  desc "Connects to S3 using our credentials"
  task :connect_s3 do 
    require 'aws/s3'
    require 'yaml'
    AWS::S3::Base.establish_connection!(YAML.load_file('config/s3.yml'))   
  end
  
  desc "Cleans any existing release on s3 before pushing over top"
  task :clean_s3 do
    objects = []
    # Apparently this doesn't return everything, so we have to keep looping until empty
    begin
      objects = AWS::S3::Bucket.objects(bucket_name, :prefix => "#{bucket_path_prefix}/#{containing_folder_name}")
      objects.each do |object|
        puts "Removing old #{object.key}"
        object.delete
      end
    end while !objects.empty?
  end
  
  desc "Push the build artifacts up to S3"
  task :push do 
    files = File.join(containing_folder_name, "**", "*")
    Dir.glob(files).each do |filename|
      next if File.directory?(filename)
      puts "Pushing #{filename}..."
      remote_path = "#{bucket_path_prefix}/" + filename
      AWS::S3::S3Object.store(remote_path, open(filename), bucket_name, :access => :public_read)
    end
  end
  
  desc "Cleans up the extract build artifacts locally"
  task :clean do
    run_locally("rm -rf #{containing_folder_name}")
  end
  
  before "deploy:clean_s3", "deploy:connect_s3"
  before "deploy:push", "deploy:connect_s3", "deploy:clean_s3"
  
  desc "Run all the necessary deploy tasks in the correct order"
  task :default do
    deploy.compress
    deploy.grab
    deploy.uncompress
    deploy.rename
    deploy.push
    deploy.clean
  end
end
