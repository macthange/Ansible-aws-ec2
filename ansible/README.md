# ansibel

## What is SSH Agent Forwarding?
SSH agent forwarding is like going another layer deeper.
For example, 
imagine you’re connecting to a remote server, 
and you want to git pull some code that you’re storing on Github. 
You want to use SSH authentication for Github, 
but you don’t want your private keys on that remote server, only on your machine.


## To solve this problem, 
you can open your local SSH agent to the remote server,
allowing it to act as you while you’re connected. 
This doesn’t send your private keys over the internet, 
not even while they’re encrypted; 
it just lets a remote server access your local SSH agent and verify your identity.

## It works like this:
 you ask your remote server to pull some code from Github,
 and Github says “who are you?” to the server.
 Usually the server would consult its own id_rsa files to answer, 
 but instead it will forward the question to your local machine. 
 Your local machine answers the question and sends the response (which does not include your private key) to the server, 
 which forwards it back to Github. 
 Github doesn’t care that your local machine answered the question,
 it just sees that it’s been answered, and lets you connect.