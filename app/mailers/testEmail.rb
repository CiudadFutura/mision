require 'net/smtp'

message = <<MESSAGE_END
From: Mision Antiinflacion <victoriacolectiva@misionantiinflacion.com.ar>
To: Daniel Molinet <daniel.molinet@gmail.com>
Subject: SMTP e-mail test

This is a test e-mail message.
MESSAGE_END


 
smtp = Net::SMTP.new 'ftbn-wbbl.accessdomain.com', 587
smtp.enable_starttls
smtp.start('ftbn-wbbl.accessdomain.com', 'victoriacolectiva@misionantiinflacion.com.ar', '!QAZzaq1', :login)
smtp.send_message message, 'victoriacolectiva@misionantiinflacion.com.ar', 'daniel.molinet@gmail.com'
smtp.finish
 