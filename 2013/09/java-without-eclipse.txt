
# [Java without Eclipse](#)
## &mdash; 08 September, 2013

This is a fact, when someone starts developping with java, he (or she) is given
an IDE: Eclipse.  

When one codes in C, using plain gcc + Makefile and a good text editor is
adviced.  This is the same for C++, bash, ruby, haskell, perl, python, bla bla
bla...  
Why would java escape the rules ?!  

* It is hard to play with classpath.
* It is boring to compile java by hand
* Eclipse is SOOOOOOO good at it !
* Eclipse has plenty of plugin to manage a project
* bla bla bla...

Of course, there are advantages ! And if these are good enough for you. Go with
eclipse And have some fun !  

### Throwing Eclipse away

For that to be clear, **I am not saying that IDEs are evil ! I am just showing
how you can avoid them, in favor of your daily tools**.  
I just finished a java project for my CS studies, on a bare notebook (without
X.org). And I had NO PROBLEM with not using Eclipse at all !  
Now let me introduce my setup. Of course, it's not as easy as double-clicking
on the eclipse-setup.exe. but it follows my ideas, and I'm happy with it !  

It needs the following:

* Your editor of choice
* JRE (O RLY?)
* JDK (U DON'T SAY)
* Know your shit !

You just have to know how to compile/run a java project.  Here is what I
learnt:  
**javac** is used for compiling, **java** to run an application.  
javac takes a .java file, and compiles it into a .class file, that you will run
with java. Who needs Eclipse to do that ?!  

<q>But real-life project are -a lot- more complicated than that !  You have to
put files in packages, classes in another directory, etc...</q>  

And you just activated my trap card...  
For sure, real project are a lot more complicated ! For example:  

    ~/src/java/eg
    ├── bin
    ├── build
    │   └── build.xml
    ├── conf
    │   └── server-log4j.properties
    ├── lib
    │   ├── junit-4.11.jar
    │   └── log4j-1.2.12.jar
    ├── src
    │   └── com
    │       └── irc
    │           ├── client
    │           │   ├── ClientConnexion.java
    │           │   ├── ClientFenetre.java
    │           │   ├── Client.java
    │           │   └── Client_TEST.java
    │           ├── server
    │           │   ├── ClientRun.java
    │           │   ├── Server.java
    │           │   └── Server_TEST.java
    │           └── utils
    │               ├── Command.java
    │               ├── Command_TEST.java
    │               ├── Communication.java
    │               ├── Communication_TEST.java
    │               └── Log.java
    └── tags

This is what my project looks like. sources are in src/, classes compiled in
bin/. Each source has it's own package.  

Let's see how to handle this project, using UNIX as your IDE !

### Compilation

It probably is the hardest part. Java is hard to compile properly, so tools
like Ant are used in IDEs.  

Basicaly, compilation goes like this:

    javac -d bin/ -sourcepath src/ -classpath bin/ src/com/irc/utils/Command.java

    -d specifies the directory where your classes will go.  
    -sourcepath tells javac where to search for source files.  
    -classpath is the same as the abode, but for class files.  

Do you see it coming ? **YES**, we will use a Makefile.  
Here is mine:

    # Locate directories
    class_d=bin
    lib_d=lib
    source_d=src
    package_d=com/irc

    # Compilation stuff
    JAVAC=javac
    JFLAGS=-g -d $(class_d) -sourcepath $(source_d) -Xlint:all

    classpath:=$(class_d):$(lib_d)/junit-4.11.jar:$(lib_d)/log4j-1.2.12.jar

    # If there's already a CLASSPATH, put it on the front
    ifneq ($(CLASSPATH),)
            classpath:= $(CLASSPATH):$(classpath)
    endif

    # Re-export the CLASSPATH.
    export CLASSPATH:=$(classpath)

    MATCH='.*[^(_TEST)]\.java'

    ifdef TEST
        ifeq ($(TEST), all)
            MATCH='.*_TEST\.java'
        else
            MATCH='.*\/$(TEST)\/.*_TEST\.java'
        endif
    endif

    # Find all the source and convert them to class files
    S_SERVER= $(shell find $(source_d)/com/irc/server -regex $(MATCH))
    C_SERVER= $(patsubst src/%.java, bin/%.class, $(S_SERVER))
    S_CLIENT= $(shell find $(source_d)/com/irc/client -regex $(MATCH))
    C_CLIENT= $(patsubst src/%.java, bin/%.class, $(S_CLIENT))
    S_UTILS= $(shell find $(source_d)/com/irc/utils -regex $(MATCH))
    C_UTILS= $(patsubst src/%.java, bin/%.class, $(S_UTILS))

    .SUFFIXES: .java .class
    .PHONY: default server client utils clean init all

    default: classes

    $(class_d)/%.class: $(source_d)/%.java
    	@echo &quot;JAVAC $&lt;&quot;
    	@$(JAVAC) $(JFLAGS) $&lt;

    classes: utils server client $(class_d)

    server: $(C_SERVER) utils
    client: $(C_CLIENT) utils
    utils: $(C_UTILS)

    all: init classes

    $(class_d):
    	mkdir $(class_d)

    clean:
    	rm -rf $(class_d)/*

It will search the appropriate sources in your sourcepath, and compile them in the
associated classpath.  
Building the tests appart is done with `make TEST=[server|client|utils|all]`
And it will compile your code only if it has changed (thanks GNU/make !).  

It there you need more explaination on this, mail me your questions !

### Running

Running your program will be a lot more easier. And you probably know What I'm
going to tell you: _shell script_.  

Simple huh ? You just need to know how to run a java program:  

    java -classpath bin/ com.irc.server.Server

Do I really need to explain what -classpath is ..?
On the other hand, "com.irc.server" is the package containing my Server class,
and "Server" is the class containing the method main().  

So you will have no problems building the correct script that will run your
application. It will probably (in its simplest form) look like this:  

    #!/bin/sh

    classpath=bin:lib/log4j-1.2.12.jar
    package=com.irc.server

    java -cp $classpath $package.Server

Isn't that easy ?

### Conclusion

**YOU. DON'T. NEED. ECLIPSE. AT ALL.**

I know that a lot of people will discard me, telling that This is a pain in the
neck to go like this, that you need to know Makefile, and take the time to
write them, etc... But these are reusable, and it helps you to know how to
manage the whole process ! Furthermore, it can be interesting to (at least) try
this method, just to see how it goes.  You will be able to use every tool you
want, git, vim, emacs, svn, ctags, ...  

No needs to get used to the Eclipse interface, and to forget about your
favorite editor ! Isn't that promising ?

<!-- vim: set ft=markdown ts=4 et: -->
