import BaseHTTPServer, SimpleHTTPServer
import ssl

class S(BaseHTTPServer.BaseHTTPRequestHandler):
    def _set_headers(self):
        self.send_response(200)
        self.send_header('Content-type', 'text/html')
        self.end_headers()

    def do_GET(self):
        self._set_headers()
        self.wfile.write("<html><body><h1>hi!</h1></body></html>")

    def do_HEAD(self):
        self._set_headers()
        
    def do_POST(self):
        # Doesn't do anything with posted data
        self._set_headers()
        self.wfile.write("<html><body><h1>POST!</h1></body></html>")

httpd = BaseHTTPServer.HTTPServer(('rxdhawkins.me', 400), S)
httpd.socket = ssl.wrap_socket (httpd.socket, certfile='/etc/apache2/ssl/rxdhawkins.me.pem', server_side=True)
print "serving..."
httpd.serve_forever()

