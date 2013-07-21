<%Option Explicit%>
<%
Dim mail_desde, mail_para, mail_cc, mail_bcc, mail_asunto, mail_Format, mail_gracias, mensaje, CdoMail, separador

mail_desde 	= Request.Form ("mail_desde")
mail_para 	= Request.Form ("mail_para")
mail_cc 	= Request.Form ("mail_cc")
mail_bcc 	= Request.Form ("mail_bcc")
mail_asunto 	= Request.Form ("mail_asunto")
mail_Format 	= Request.Form ("mail_Format")
mail_gracias 	= Request.Form ("mail_gracias")



'Response.write "desde:" & mail_desde & "<br>"
'Response.write "para:" & mail_para & "<br>"
'Response.write "cc:" & mail_cc & "<br>"
'Response.write "bcc:" & mail_bcc & "<br>"
'Response.write "asunto:" & mail_asunto & "<br>"
'Response.write "format:" & mail_Format & "<br>"
'Response.write "gracias:" & mail_gracias & "<br>"



'Preparo el mensaje que va a llegar en el correo.

response.write lcase(mail_Format)

	if (lcase(mail_Format) = "html") then
		separador = "<br>"
	Else
		separador = vbCrLf
	end if


mensaje = "Nombre: " & Request.Form ("nombrecliente") & separador
mensaje = mensaje & "Direccion: " & Request.Form ("direccion") & separador
mensaje = mensaje & "Email: " & Request.Form ("Email_Address") & separador
mensaje = mensaje & "Ciudad: " & Request.Form ("ciudad") & separador
mensaje = mensaje & "Pais: " & Request.Form ("pais") & separador
mensaje = mensaje & "Telefono: " & Request.Form ("telefono") & separador
mensaje = mensaje & "Comentario: " & Request.Form ("comentarios") & separador



'Envio del Formulario por correo

Set CdoMail = Server.CreateObject("CDO.Message")

	CdoMail.From = mail_desde

	CdoMail.To = mail_para

	CdoMail.cc = mail_cc 	

	CdoMail.bcc = mail_bcc 	

	CdoMail.ReplyTo = Request.Form ("Email_Address")

	CdoMail.Subject = mail_asunto


	if (lcase(mail_Format) = "html") then
		CdoMail.HtmlBody = mensaje
	Else
		CdoMail.TextBody = mensaje
	end if


	CdoMail.Send

set CdoMail =nothing

Response.Redirect(mail_gracias)

%>

