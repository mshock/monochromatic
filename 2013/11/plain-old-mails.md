# [Plain old mails](#)
## &mdash; 04 November, 2013

On my way to meet the default UNIX tools, I ran into a simple one: `mail`, that
was sitting in the corner of my system playing with.. Nothing in fact.  
`mail` is one of that small utilities that have been forgotten and replaced by
more "moderns" tools like mutt, alpine or even thunderbird. But it is worth
knowing about !

`mail` can manipulate a mail box in either mbox or Maildir format, and is
intelligent enough to know the difference between the two of them.  
It can also handle IMAP mail boxes, but for this post, I'll assume you use a
local mail directory under `$HOME/var/mail/INBOX/`

Because we all need that bearded touch, we will use `mail` as our **main mail
user agent**.

### The environment

As any of the standard UNIX tool, `mail` integrates well in a UNIX environment,
and is able to interact with external tools to perform specific action (assume
it, you love that huh?).

Here is the set of variable `mail` is going to use:

* `MAIL`: The default mail box
* `EDITOR`: The default editor to use
* `VISUAL`: The default visual editor to use

And that all ! We will not need more to get a running set up (For
more infos, you can check the mail(1) manpage).

So here we go. Make sure those two variables are exported:

    $ export MAIL=$HOME/var/mail/INBOX
    $ export EDITOR=ed
    $ export VISUAL=vim

Now, we will create the most basic directory tree needed by the
setup (We will improve it later)

    $ tree $HOME/var/mail
    /home/z3bra/var/mail/
    └── INBOX
    ├── cur
    ├── new
    └── tmp

    4 directories, 0 files

Ok, now the mail environment is set up. You can try the `mail` command at this
point, but an empty mail tree will only result in the following message:

    No mail for z3bra

For future convenience, copy your /etc/mail.rc to
~/.mailrc, so we will be able to edit it later.


Before continuing with mail, we will take a look at two mail related programs,
[fdm](http://fdm.sourceforge.net/) and [msmtp](http://msmtp.sourceforge.net/),
that we will use to fetch and deliver emails.

### Fetching mails

FDM stands for <q>Fetch and Deliver Mails</q>, so it basically get mails from a
server, and place them in your local filesystem based on regex rules.  
If you want a great tutorial for fdm, check out the
[FDM Quick start guide](http://fdm.sourceforge.net). I'll just give you my
own (simplified) config file:

    action "INBOX"           maildir "%h/var/mail/INBOX"

    account "<account-name>"
    pop3s
    server "<pop3-server>"
    new-only
    cache "~/var/mail/.cache"
    keep # Keeps mails on the server

    match all action "INBOX"

`FDM` can get infos from your `~/.netrc` file, which looks like this:

    machine <pop3-server>
    login <email@domain.tld>
    password <password>

check that mail fetching works with `fdm -kv fetch`.
If it works, you could place `fdm fetch` in your cron entries.

### Sending mails

`MSMTP` is as simple to use as `fdm`. Check its
[documentation](http://msmtp.sourceforge.net/documentation.html).
Here is a simplified config file:

    defaults
    auth            on

    account         <account-name>
    user            <email@domain.tld>
    from            <email@domain.tld>
    host            <stmp-server>
    port            25

    account default : <account-name>


`msmtp` will also read your `~/.netrc` file to get your password.

by default, `mail` uses `sendmail` (guess what it does...). Add the following
at the end of  your `~/.mailrc`:

    ~/.mailrc
    ...
    # use msmtp instead of sendmail
    set sendmail="/usr/bin/msmtp"

### Writing a new mail

Back to the topic!  
Now that tools we are going to interact with are set up, let's write
and send out first mail.
We will send this mail to ourselves, so let's go like this:

    $ mail email@domain.tld
    Subject: Testing a new MUA
    Here is the top of the mail.
    You are actually typing like in ed's insert mode.

    To stop typing, just type a dot on its own line
    .
    EOT

This will send a mail to the given address. Nothing more. Nothing less.  
You can give multiple address to send the mail to multiple contacts.

If you need more flexibility (e.g. using your own editor, or input
the text dynamically within a script, keep in mind that you can do
the following:

    $ echo "<E-mail body goes here>" | mail -s "<subject>" <email@domain.tld>
    $ vim /tmp/body.txt
    $ mail -s "<subject>" <email@domain.tld> < /tmp/body.txt


As you might guess, the `-s` can be used to specify the subject. There are also
`-c <CC-field>`, `-b <BCC-field></code> for copy/carbin copy, and so on. Just
read the manpage for more options.

### Reading your mails

To read your mail, it's quite simple. Just type `mail` to get an output like:

    $ mail
    mail version v14.4.4.  Type ? for help.
    "/home/z3bra/var/mail/INBOX": 4 messages 1 unread
    O 1 contact@domain.tld Thu Jan  1 01:00  140/5273  Blah blah, subject
    A 2 me@mail.domain.tld Thu Jan  1 01:00   95/5869  RE: Previous subject
    A 3 NEWS GROUPS        Thu Jan  1 01:00  222/15606 TR: Check this out!
    >U 4 willy@mailoo.org   Thu Jan  1 01:00  104/4146 >Testing a new MUA
    ? 

The `?` at the end is a prompt. You can input commands like `print <num>` to
display the content of the mail number "num".  
You can use abbreviations for commands: "p" is the same as "print".  "e" means
"edit", "v" means "visual".

There are A LOT of commands (to delete mails, encrypt/decrypt, copy to folders,
manage aliases, ...)  

You can even define macros, to make action like, add sender to aliases, mark as
read, copy to another folder and delete the current mail.

Today, I discovered `mail` which does anything I need to manage my e-mails. I'll
probably make the switch from mutt on all my machines once I'll be used to it.  

This little discovery reminded me that UNIX was and still is a great operating
system, regardless of all the tools that have been developped since its birth.

I hope you (re)learnt something with this article. I don't hear about `mail`
that much nowadays, although it's really usable and functionnal. I feel like a
pokemon hunter. Aware that there are many, many tools out there, of different
forms, with different purpose... I'll probably never use them all. But I'll try!

<!-- vim: set ft=markdown ts=4 et: -->
