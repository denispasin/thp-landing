# frozen_string_literal: true

require 'google_drive'

Handler = proc do |req, res|
  name = req.query['name']
  email = req.query['email']

  session = GoogleDrive::Session.from_service_account_key(StringIO.new(ENV['GOOGLE_AUTH']))
  ws = session.spreadsheet_by_key('1EJwzrr6Gq4xhYfdVGyVIRuy2jyu7Xz-wW9m-7NedUQo').worksheets[0]

  new_line = first_empty_line(ws)
  ws[new_line, 1] = name
  ws[new_line, 2] = email
  ws.save

  res.status = 200
  res['Content-Type'] = 'text/plain'
  res.body = "#{name} #{email}"
end

def first_empty_line(ws)
  line = 1
  line += 1 until ws[line, 1]&.empty?
  line
end
