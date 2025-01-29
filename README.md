## ScuolaDRMFree
ScuolaDRMFree was created because I believe in free study, I am opposed to limiting the tools available to users to study.
This software allows you to remove DRM from the school ebooks provided by scuolabook.it, so you can use the ebooks as you wish.

Be careful though, using this software it may be possible to do many negative things such as violating copyright, these practices are absolutely not approved by me, I believe that violating copyright is a bad thing and you should not use my software as an helper to do it.

**By removing DRMs you should use the material responsibly, without causing harm to others!**

## Requirements
To compile this software you need a D compiler and the dub build tool, for more information https://dlang.org

If your distro doesn't have a D and dub package you might consider using the Snap packages that I maintain myself: https://snapcraft.io/dmd and https://snapcraft.io/dub

## Build
```
git clone https://github.com/ErnyTech/ScuolaDRMFree
cd ScuolaDRMFree
dub build --build=release
```

## Use
Just call a compiled executable without any arguments, you will be returned a series of **book ids** contained in your ScuolaBook client (the ScuolaBook app must be installed throughout the process and the books you want to free from DRM must have been downloaded).

To convert a book, just call the executable with the following syntax:
```
./scuoladrmfree [BOOK ID] [OUTPUT PDF PATH]
```

So if for example the id of the book to be downloaded is "hellobook_45334" and i want to create a pdf without drm in the folder "/home/user8/out.pdf", I will have to call the software like this:
```
./scuoladrmfree hellobook_45334 /home/user8/out.pdf
```

In a few seconds the software will generate all the keys necessary to decipher the book and will ask you to confirm to continue (just press any key), then the removal of the DRM will begin.

It takes a couple of seconds to generate a clean DRM PDF!

## Copyright info
    Copyright (C) Erny
    Copyright (C) Davide for the reverse engineering of cipher algorithms

    All rights reserved. No warranty, explicit or implicit, provided.
