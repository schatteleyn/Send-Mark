#!/usr/local/bin/ruby

require 'net/smtp'
require 'csv'
require 'io/console'

def send_email(subject, toaddr, studentName, note)
	#Name and adress of the expeditor
	fromaddr = "<92824@supinfo.com>"
	fromname = base64_encode("Simon CHATTELEYN")
	
	subject = base64_encode(subject)
	
	#Definition of message body
	message = "Bonjour #{nameStudent},\n\n"
		if note == "absent"
			message += "Voici ta note : #{note}"
		else
			message += "Voici ta note : #{note}/20"
	message += "\n\nCordialement,\nSimon Chatteleyn"
	
	#Headers + message
	msg = "From: #{fromname} Subject: #{subject} X-Mailer: Ruby smtp\r\nContent-Type: text/plain; charset=\"utf-8\"\r\n\r\n #{message}"
	
	#Send the mail
	puts "Sending to #{toaddr}"
	begin
		email = smtp.send_message msg, fromaddr, to
		if email
			puts "Email sent !"
	rescue
		puts "Something went wrong. The mail haven't been send to id " + row[0]
	end
	
end

#Ask for the mail's subject
puts "Sujet du mail: "
	subject = gets.chomp

#Work only with Ruby 1.9.3, use stty -echo if not using this version
print "SMTP account's password: "
	pwd = $stdin.getch.chomp


#Open SMTP connection
#Net::SMTP.start('your.smtp.server', 25, 'mail.from.domain','Your Account', 'Your Password', :plain OR :login OR :cram_md5)
Net::SMTP.start('pod51002.outlook.com', 587, 'outlook.com', '92824@supinfo.com', '#{pwd}', :login) do |smtp|
	begin
		getNote = CSV::Reader.parse(File.open('notes.csv', 'rb', ';')).each do |row|
	rescue
		puts "Fichier introuvable. Vérifier le nom ou la localisation"
	end
		send_email(subject, row[0], row[1], row[2])
end