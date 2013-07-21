<?php

//var_dump($_REQUEST);

var_dump($_FILES);

//Subir el archivo a carpeta en el servidor con move_uploaded_file
move_uploaded_file($_FILES["file_upload"]["tmp_name"]);

//Preparar mail con PHP mailer y enviarlo
require 'class.phpmailer.php';

//Create a new PHPMailer instance
$mail = new PHPMailer();
// Set PHPMailer to use the sendmail transport
//$mail->IsSendmail();
$mail->IsSMTP();
//Enable SMTP debugging
// 0 = off (for production use)
// 1 = client messages
// 2 = client and server messages
$mail->SMTPDebug  = 2;
//Ask for HTML-friendly debug output
$mail->Debugoutput = 'html';
//Set the hostname of the mail server
$mail->Host       = "216.59.32.95";
//Set the SMTP port number - likely to be 25, 465 or 587
$mail->Port       = 25;
//Whether to use SMTP authentication
$mail->SMTPAuth   = true;
//Username to use for SMTP authentication
$mail->Username   = "contacto@compradlis.com";
//Password to use for SMTP authentication
$mail->Password   = "vial215ojosa";
//Set who the message is to be sent from
$mail->SetFrom('info@compradlis.com', "D'lis");
//Set an alternative reply-to address
$mail->AddReplyTo('info@compradlis.com', "D'lis");
//Set who the message is to be sent to
//$email = $_REQUEST['email'];
$email = 'adriang_1174@hotmail.com';
$mail->AddAddress('adriang_1174@hotmail.com', 'Adrian Garcia');
//Set the subject line
$mail->Subject = 'PHPMailer sendmail test';
//Read an HTML message body from an external file, convert referenced images to embedded, convert HTML into a basic plain-text alternative body
$msg = '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <title>Nuevo Contacto</title>
</head>
<body>
  <div style="width: 640px; font-family: Arial, Helvetica, sans-serif; font-size: 11px;">
    <h1>Un contacto ha completado el formulario</h1>
    <div align="center">
		Nombre: {$_REQUEST["nombre"]}
		Ciudad: {$_REQUEST["ciudad"]}
		Email: {$_REQUEST["email"]}
		Telefono: {$_REQUEST["telefono"]}
		Consulta: {$_REQUEST["consulta"]}
	</div>
  </div>
</body>
</html>';
$mail->MsgHTML($msg);
//Replace the plain text body with one created manually
$msg_txt = '  Un contacto ha completado el formulario
		Nombre: {$_REQUEST["nombre"]}
		Ciudad: {$_REQUEST["ciudad"]}
		Email: {$_REQUEST["email"]}
		Telefono: {$_REQUEST["telefono"]}
		Consulta: {$_REQUEST["consulta"]}
';
$mail->AltBody = $msg_txt;
//Attach an image file
$mail->AddAttachment('./'.$_FILES["file_upload"]["tmp_name"]);

//Send the message, check for errors
if(!$mail->Send()) {
  echo "Mailer Error: " . $mail->ErrorInfo;
} else {
  echo "Message sent!";
}

?>