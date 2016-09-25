# prompt-you

[![Marmalade](https://img.shields.io/badge/marmalade-available-8A2A8B.svg)](https://marmalade-repo.org/packages/prompt-you)  
[![License](https://img.shields.io/badge/LICENSE-GPL%20v3.0-blue.svg)](https://www.gnu.org/licenses/gpl.html)
[![Gratipay](http://img.shields.io/gratipay/myTerminal.svg)](https://gratipay.com/myTerminal)

A simple library to prompt user to select from a list of options, for Emacs

## Installation

### Manual

Save the file *prompt-you.el* to disk and add the directory containing it to `load-path` using a command in your *.emacs* file like:

    (add-to-list 'load-path "~/.emacs.d/")

The above line assumes that you've placed the file into the Emacs directory '.emacs.d'.

Start the package with:

    (require 'prompt-you)

### Marmalade

If you have Marmalade added as a repository to your Emacs, you can just install *prompt-you* with

    M-x package-install prompt-you RET

## Usage

You can show a prompt with options as

    (prompt-you-now
        "What would you like to do?"
        (list '("1" 
                "Invert colors" 
                (lambda ()
                    (invert-face 'default)))
              '("2" 
                "Clean frame" 
                (lambda ()
                    (menu-bar-mode -1)
                    (tool-bar-mode -1)
                    (scroll-bar-mode -1)))))

## Let me know

Let me know your suggestions on improving *prompt-you* at ismail@teamfluxion.com

Thank you!
