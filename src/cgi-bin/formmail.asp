<%Option Explicit%>
<!--#include file="Loader.asp"-->
<%
Dim mail_desde, mail_para, mail_cc, mail_bcc, mail_asunto, mail_Format, mail_gracias, mensaje, CdoMail, separador
' load object
Dim load
	  'Loader loads file and input fields from multipart request
      Set load = new Loader
	  ' calling initialize method
      load.initialize

mail_desde 	= load.getValue("email")
mail_para 	= "info@compradlis.com"
mail_asunto 	= "Contacto www.compradlis.com"
mail_Format 	= "html"


'Preparo el mensaje que va a llegar en el correo.

response.write lcase(mail_Format)

	if (lcase(mail_Format) = "html") then
		separador = "<br>"
	Else
		separador = vbCrLf
	end if

mensaje = "Datos:" & separador
mensaje = mensaje & "Nombre: " & load.getValue("nombre") & separador
mensaje = mensaje & "Email: " & load.getValue("email") & separador
mensaje = mensaje & "Ciudad: " & load.getValue("ciudad") & separador
mensaje = mensaje & "Telefono: " & load.getValue("telefono") & separador
mensaje = mensaje & "Comentario: " & load.getValue("consulta") & separador

'
' Upload del file
'
 ' File binary data
   Dim fileData
      fileData = load.getFileData("file_upload")
   ' File name
   Dim fileName
      fileName = LCase(load.getFileName("file_upload"))
   ' File path
   Dim filePath
      filePath = load.getFilePath("file_upload")
   ' File path complete
   Dim filePathComplete
      filePathComplete = load.getFilePathComplete("file_upload")
   ' File size
   Dim fileSize
      fileSize = load.getFileSize("file_upload")
   ' File size translated
   Dim fileSizeTranslated
      fileSizeTranslated = load.getFileSizeTranslated("file_upload")
   ' Content Type
   Dim contentType
      contentType = load.getContentType("file_upload")
   ' No. of Form elements
   Dim countElements
      countElements = load.Count
   ' Path where file will be uploaded
   Dim pathToFile
      pathToFile = Server.mapPath("uploaded/") & "\" & fileName
   ' Uploading file data
   Dim fileUploaded
      fileUploaded = load.saveToFile ("file_upload", pathToFile)
      


'Envio del Formulario por correo

Set CdoMail = Server.CreateObject("CDO.Message")

	CdoMail.From = mail_desde

	CdoMail.To = mail_para

	CdoMail.cc = mail_cc 	

	CdoMail.bcc = mail_bcc 	

	CdoMail.Subject = mail_asunto
   
	
	if fileName <> "" then
		Dim fileURL
		fileURL = "http://www.compradlis.com/cgi-bin/uploaded/" & fileName
		
		CdoMail.AddAttachment fileURL
	end if
	
	if (lcase(mail_Format) = "html") then
		CdoMail.HtmlBody = mensaje
	Else
		CdoMail.TextBody = mensaje
	end if

	CdoMail.Send

set CdoMail = Nothing
' destroying load object
Set load = Nothing

'Try to remove uploaded file from server
Dim fs
Set fs=Server.CreateObject("Scripting.FileSystemObject")
if fs.FileExists(pathToFile) then
  fs.DeleteFile(pathToFile)
end if

Response.Redirect("http://www.compradlis.com/COMPRADLIS.gracias.htm")
%>




