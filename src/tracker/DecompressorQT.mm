/*
 *  tracker/DecompressorQT.cpp
 *
 *  Copyright 2008 Peter Barth
 *
 *  This file is part of Milkytracker.
 *
 *  Milkytracker is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  Milkytracker is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with Milkytracker.  If not, see <http://www.gnu.org/licenses/>.
 *
 */
 
/*
 *  DecompressorQT.cpp
 *  milkytracker_universal
 *
 *  Created by Peter Barth on 22.06.08.
 *
 */

#include "DecompressorQT.h"
#include "XMFile.h"

#import <Foundation/NSAutoreleasePool.h>
#import <QTKit/QTKit.h>
#import "AIFFWriter.h"

// -- QT --------------------------------------------------------------------
DecompressorQT::DecompressorQT(const PPSystemString& filename) :
	DecompressorBase(filename)
{
}

bool DecompressorQT::identify(XMFile& f)
{
	bool res = true;

	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	
	NSString* filename = [NSString stringWithUTF8String:f.getFileName()];
	
	id qtError = nil;
	id movie = [QTMovie movieWithFile:filename error:&qtError];	
	
	res = (nil == qtError);
	
	[pool release];
	return res;	
}	
	
bool DecompressorQT::decompress(const PPSystemString& outFilename)
{
	bool res = true;

	NSAutoreleasePool* pool = [[NSAutoreleasePool alloc] init];
	
	NSString* filename = [NSString stringWithUTF8String:fileName];
	
	id qtError = nil;
	id movie = [QTMovie movieWithFile:filename error:&qtError];	
	
	if (nil == qtError) 
	{			
		AIFFWriter* aiffWriter = [[AIFFWriter alloc] init];
	
		if (TRUE == [[movie attributeForKey:QTMovieHasAudioAttribute] boolValue]) 
		{
			OSStatus err = [aiffWriter exportFromMovie:movie toFile:[NSString stringWithUTF8String:outFilename]];
			if (err != noErr)
			{
				res = false;
			}
		} 
		else 
		{
			// movie contains no audio track
			res = false;
		}
		
		[aiffWriter release];			
	} 
	else 
	{
		// Some error has occured
		res = false;
	}
	
	[pool release];
	return res;	
}

DecompressorBase* DecompressorQT::clone()
{
	return new DecompressorQT(fileName);
}	

static Decompressor::RegisterDecompressor<DecompressorQT> registerDecompressor;
