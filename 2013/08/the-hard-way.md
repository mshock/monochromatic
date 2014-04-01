
# [The Hard way](#)
## &mdash; 9 August, 2013

As you will notice, I am fond of learning things "The Hard Way".  
I'm going to tell you why, but before that, here is my background, so that you'll understand
how I came to that opinion:

* **2011, september** &mdash; First attempt at linux, dual-booting Ubuntu 10.10
* **2012, february** &mdash; Upgrading to Archlinux, single booting
* **2012, june** &mdash; Obtaining an old computer, and setting it up as a home server
* **2012, december** &mdash; Switching to Archlinux at work, single booting
* **2013, july** &mdash; Installing CRUX on my notebook

I have alway tried to put myself in difficulties, to challenge myself and learn
new things.  During this period, I have searched plenty of tools matching the
Unix Philosophy, by <cite>Ken Thompson</cite>:

> Write programs that do one thing and do it well. Write programs to work together.
> Write programs to handle text streams, because that is a universal interface.

This is the reason why I prefer using CLI based tools rather than GUI based
ones. I've come to the point where grabbing the mouse to click on a button is a
_real_ pain.  
But let's go back to **the hard way**.

### What is that ? Can I eat it ?

Learning stuff the hard way is (talking about computers), starting using tools
or learning stuff, without a formation, any piece of help, or any hack to make
it more simple to use/learn.  
Being put in front of a difficulty will force you to search how something
works, how do this or that, and you will know what not to do after you did it.  
Basically, by learning tstuff his way **you will learn from your mistakes, and
understand what you are doing**.  

To illustrate this, I will use my own experience with a hard to master tool:
Vim.  

Vim, is an extremly powerful modal text editor. Modal means here that there are
multiple modes, each one made to do different tasks. We see here that it is
totally different from the standard text editor everyone knows (I'm looking at
you notepad...).  
Vim is hard to approach, and difficult to master, because of your good ol'
reflexes. So it is an excellent tool to learn how to learn the hard way!  
Here are the basic steps:

1. Use it as your _main editor_, stop using every other alternatives
2. Use it _before_ starting to configure it
3. Do not use any plugin _at all_
4. Don't give up !

Using Vim this way (at least, at the beginning), will help you mastering the
tool faster than learning progressively.  Of course, you could still use the
mouse, until you are ready to stop using it, use the arrow keys to move within
the buffer, delete by selecting your text in visual mode, and pressing
`<SUPPR>`.  
But, WHEN will you be ready ? WHEN will you force yourself not to do that ? WHY
not doing this now?  

I forced myself to use it this way, and after a week or two, I was putting
":wqjk{wB" in every other text editor, because I were finally comfortable with,
and used to Vim.

### Drawbacks

I see you raising the <q>I can't have a productivity loss at my work</q> card,
and you are right.  This method is not shipped with only advantages, and
sometimes, you should avoid it. If you think that you can't handle a
productivity loss, postpone the learning for when you will have the time. But
don't do that to much, because you have to be aware that **you will have a
productivity loss**. So I will ask a single question:  
<q>Before being ultra-productive, would you rather be totally unproductive for
one week, or almost productive for one month ?</q>  
Actually, I have never suffered from that 'bad productivity' the hard way
implies. And believe me, it's worth the pain!

This is all about choice. Everybody has his learning curve, find yours!  
If you're not convinced about this. Please try it. You will, at least, have
your own opinion, which is great.  
After that, you will be more pleased to tell if the tool is made for you or
not, and if you want to make your life easier. (Show me one Vim user that has
choosen to enable the mouse because it enhance his productivity... I dare you
;) ).

### Homeworks

There are a lot of place in the UNIX domain where the hard way can be applied,
here are a few examples:

* Write shell script that uses multiple tools to reproduce the behavior of
  another tool (eg, [irc it](http://tools.suckless.org/ii))
* Switch from a desktop environnement to a standalone window manager, like
  [evilwm](http://www.6809.org.uk/evilwm/)
* When you master a tool, search for another one, less featured
* Put yourself in difficulties. Don't be affraid to break things
* **Break things!**
* ...

I hope I conviced you, at least, to try it. It might be hard at first, But
that's the point.

<!-- vim: set ft=markdown ts=4 et: -->
