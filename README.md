## Basic usage

1. Start server

	sh SERVE.sh [language] (--silent)

Optionally add a language: `spanish`, `english`, or `chinese` are supported.

Optionally add `--silent` to the end to suppress printed output (which makes everything run faster).

2. Send requests

	* using wget

		wget --post-data 'I like her because she is nice' 'http://localhost:12345/?properties={"annotators":"tokenize","outputFormat":"json"}' -O -

	* using curl

		curl --data 'It did not however , cover any sort of local taxes or similar measures' 'http://localhost:12345/?properties={%22annotators%22%3A%22tokenize%2Cssplit%2Cdepparse%2Cpos%22%2C%22outputFormat%22%3A%22json%22}' -o -

	* using python

		import requests
		data = "The quick brown fox jumped over the lazy dog."
		url = "http://localhost:12345?properties={annotators:'tokenize,ssplit,pos,depparse'}"
		parse_string = requests.post(url, data=data).text
		return json.loads(parse_string)["sentences"][0]

	* using javascript

		var properties = {annotators: "tokenize"};
		var property_string = JSON.stringify(properties);
		var properties_for_url = encodeURIComponent(property_string);
		$.ajax({
	      type: "POST",
	      url: 'http://' +
	        'whatever-the-public-DNS-is/' +
	        '?properties=' +
	        properties_for_url,
	      data: 'The quick brown fox jumped over the lazy dog.',
	      success: function (data){
	        parse = data;
	        console.log(parse);
	      },
	      error: function (responseData, textStatus, errorThrown) {
	        alert('POST failed.');
	      }
		});

## Installation

On linux:

	sh INSTALL.sh

On mac, just look at the `INSTALL.sh` file and take the appropriate lines from there...

## On Digital Ocean

On Robert's server, when everything is already installed, open screeni `screen` or `screen -r` and run:

    sh SERVE.sh

and in another screen (`control+a c`)

    python server.py

Then detach with `control+a a` `control+a d`. Use `control+a n` to switch between screens. Type `exit` when done.

- - - -

This is for when I want to spin up an NLP server on EC2 for access from a web browser. I need to install CoreNLP and listen for POST requests.

## Setting up the EC2 instance

### Prerequisites

* set up an AWS account

### Set up a new instance

1. Go online to the EC2 Dashboard in the AWS console.

	* **Warning:** Pay attention to your *Region*, in the upper right corner of this page. I once had instances running for a couple months on a different region, so I didn't see that they were running and I didn't know how to turn them off.

2. Go to EC2 Instances (in the left panel)

3. Launch Instance

	* **Step 1: Choose an Amazon Machine Image (AMI)**

		Ubuntu Server 16.04 LTS (HVM), SSD Volume Type - ami-16efb076

	* **Step 2: Choose an Instance Type**

		**t2.small** ~ this has 2g memory, which we need to run the server (actually, more sophisticated NLP would require more memory, but this is enough for dependency parsing)

	* skip through the next steps (keep the defaults):
		* **Step 3: Configure Instance Details**
		* **Step 4: Add Storage**
		* **Step 5: Add Tags**

	* **Step 6: Configure Security Group**

		Add rules for HTTP and HTTPS, accept the default settings. It will warn you about security. I'm ignoring this.

	* **Step 7: Review Instance Launch**

		Click launch and make a new key pair if you need to. This will be a file that ends with .pem, e.g. `key.pem`. I put this file in my home `.ssh` directory `~/.ssh/key.pem`.

3. View Instances and get Public DNS

You should see one instance that's being set up. Select that instance and you'll see the properties of that instance on the bottom of the page. Copy the *Public DNS (IPv4)*, which will look something like `ec2-54-219-187-44.us-west-1.compute.amazonaws.com
`. In the rest of this README, I will call this address `whatever-the-public-DNS-is`.

4. SSH to the instance

	ssh ubuntu@whatever-the-public-DNS-is -i path/to/key.pem

## Once you're SSHed into an Ubuntu instance

Clone this repo into your home directory. Then run `INSTALL.sh` on a new instance. That will set everything up.

When the installation is done, you can start running the server by running `SERVE.sh`.

Here are some example requests:

	wget --post-data 'I like her because she is nice' 'http://localhost:12345/?properties={"annotators":"tokenize","outputFormat":"json"}' -O -

	curl --data 'It did not however , cover any sort of local taxes or similar measures' 'http://localhost:12345/?properties={%22annotators%22%3A%22tokenize%2Cssplit%2Cdepparse%2Cpos%22%2C%22outputFormat%22%3A%22json%22}' -o -

And here's an example request from a browser:

	var properties = {annotators: "tokenize"};
	var property_string = JSON.stringify(properties);
	var properties_for_url = encodeURIComponent(property_string);
	$.ajax({
      type: "POST",
      url: 'http://' +
        'whatever-the-public-DNS-is/' +
        '?properties=' +
        properties_for_url,
      data: 'The quick brown fox jumped over the lazy dog.',
      success: function (data){
        parse = data;
        console.log(parse);
      },
      error: function (responseData, textStatus, errorThrown) {
        alert('POST failed.');
      }
	});

Note that with only 2g of memory, we won't be able to run *all* of the annotators. But "tokenize,ssplit,pos,depparse" works fine, and that's all I need for many uses.

# Multilingual


