import BaseHTTPServer, SimpleHTTPServer
import ssl
import requests
from nlp import process_parsed_data
import os

SERVER_ADDRESS = (HOST, PORT) = 'rxdhawkins.me', 8882

class S(BaseHTTPServer.BaseHTTPRequestHandler):
    def _set_headers(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.send_header('Access-Control-Allow-Origin', 'https://rxdhawkins.me')
        self.end_headers()

    def do_GET(self):
        self._set_headers()
        self.wfile.write("<html><body><h1>hi!</h1></body></html>")

    def do_HEAD(self):
        self._set_headers()

    def do_POST(self):
        content_length = int(self.headers['Content-Length'])
        post_data = self.rfile.read(content_length)
        url = "http://localhost:12345?properties={annotators:'tokenize,ssplit,pos,depparse,lemma,coref'}"
        data = post_data
        print(data)
        parse = requests.post(url, data=data).text
        output = process_parsed_data(parse)
        self._set_headers()
        self.wfile.write(output)
        #self.wfile.write("<html><body><h1>POST!</h1></body></html>")

httpd = BaseHTTPServer.HTTPServer(('rxdhawkins.me', 8882), S)
httpd.socket = ssl.wrap_socket (httpd.socket, certfile='/etc/apache2/ssl/rxdhawkins.me.pem', server_side=True)
print "serving..."
httpd.serve_forever()

