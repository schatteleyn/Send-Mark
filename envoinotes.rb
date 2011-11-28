require 'net/smtp'
require 'csv'

def send_email(subject, toaddr, studentName, note)
	fromaddr = "<92824@supinfo.com>"
	fromname = "Simon CHATTELEYN"
	   
	message = "Bonjour #{nameStudent},\n\n"
		if note == "absent"
			message += "Voici ta note : #{note}"
		else
			message += "Voici ta note : #{note}/20"
	message += "\n\nCordialement,\nSimon Chatteleyn"
	
	msg = "From: #{fromname} Subject: #{subject} X-Mailer: Ruby smtp\r\nContent-Type: text/plain; charset=\"utf-8\"\r\n\r\n" + message
	Net::SMTP.start('pod51002.outlook.com', 587) do |smtp|
		smtp.send_message msg, fromaddr, to
	end
end

puts "Sujet du mail: "
	subject = gets.chomp
	
getNote = CSV::Reader.parse(File.open('notes.csv', 'rb')).each do |row|
	send_email(subject, row[0], row[1], row[2])