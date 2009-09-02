function define(name, params, desc, def) {
  document.write("<p style=margin-left:0.2in><b>"+name+"</b> <font color=#294F75><i>"+params+"</i></font><p style=margin-left:0.4in>"+desc+"<br><i>Default: "+def+"</i></p>");
}

function macro(name, params, desc) {
  document.write("<p style=margin-left:0.2in><b>"+name+"</b> <font color=#294F75><i>"+params+"</i></font><p style=margin-left:0.4in>"+desc+"</p>");
}
