import requests
from nlp import process_parsed_data
import os

from BaseHTTPServer import HTTPServer, BaseHTTPRequestHandler
from SocketServer import ThreadingMixIn
import threading
import ssl

class Handler(BaseHTTPRequestHandler):

    def do_GET(self):
        # self._set_headers()
        # self.wfile.write("<html><body><h1>hi!</h1></body></html>")
        self.send_response(200)
        self.end_headers()
        message =  threading.currentThread().getName()
        self.wfile.write(message)
        self.wfile.write('\n')
        return

    def _set_headers(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.send_header('Access-Control-Allow-Origin', 'https://rxdhawkins.me')
        self.end_headers()

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

class ThreadedHTTPServer(ThreadingMixIn, HTTPServer):
    """Handle requests in a separate thread."""

if __name__ == '__main__':
    server = ThreadedHTTPServer(('rxdhawkins.me', 8882), Handler)
    server.socket = ssl.wrap_socket(server.socket, certfile='/etc/apache2/ssl/rxdhawkins.me.pem', server_side=True)
    print 'Starting server, use <Ctrl-C> to stop'
    server.serve_forever()

