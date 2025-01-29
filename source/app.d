/* 
Copyright (C) Erny

    This file is part of ScuolaDRMFree.
    All rights reserved. No warranty, explicit or implicit, provided.
*/

void main(string[] args) {
	import std.stdio : writeln, readln;
	import std.path : absolutePath, dirName;
	import std.file : write, exists, isDir;
	import drm : computePdfMagics, removeDrm;
	import util : parseScuolaDb, readPdf, printPdfList;

	writeln();
	writeln("Welcome to ScuolaDRMFree!");
	writeln("Copyright (C) Erny");
	writeln("Copyright (C) Davide for the reverse engineering of cipher algorithms");
	writeln();

	auto scuoladb = parseScuolaDb();

	if (args.length != 3) {
		writeln("Usage: [BOOK ID] [OUTPUT PDF PATH]");
		writeln();
		printPdfList(scuoladb);
		return;
	}

	auto bookName = args[1];
	auto outputPath = args[2].absolutePath;
	assert(outputPath.dirName.exists && outputPath.dirName.isDir, "The output path directory does not exist");
	auto pdf = readPdf(bookName, scuoladb);
	auto magics = computePdfMagics(bookName, pdf, scuoladb);
	writeln("Output path: ", outputPath);
	writeln();
	writeln("--------");
	writeln("USE THIS SOFTWARE ONLY TO REMOVE THE DRM FROM BOOKS, TO ALLOW YOU A STUDY IN FREEDOM!");
	writeln("PLEASE DO NOT INFRINGE THE COPYRIGHT WITH THIS TOOL, THE DRM WOULD NOT EXIST IF EVERYONE WAS RESPONSIBLE");
	writeln("--------");
	writeln();
	writeln("Press any key to confirm the removal of the DRM");
	readln();
	removeDrm(magics, pdf);
	write(outputPath, pdf);
	writeln();
	writeln("DRMs have been successfully removed!");
	writeln("Your eBook is freely available at ", outputPath);
}
