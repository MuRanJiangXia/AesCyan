/*
 Copyright (C) 2007-2009 Stig Brautaset. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 * Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.
 
 * Neither the name of the author nor the names of its contributors may be used
   to endorse or promote products derived from this software without specific
   prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "NSString+SBJSON.h"
#import "SBJsonParser.h"

@implementation NSString (NSString_SBJSON)

-(id)DeepConvret:(id)pObj
{
    id pNewObj = pObj;
    
    if ([pObj isKindOfClass:[NSDictionary class]])
    {
        NSDictionary* pDict = pObj;
        NSMutableDictionary *pNewDict = [NSMutableDictionary dictionaryWithCapacity:[pDict count]];
        
        for (id pUsb in pDict.allKeys)
        {
            id pNewSub = [self DeepConvret:[pDict objectForKey:pUsb]];
            if (pNewSub)
                [pNewDict setObject:pNewSub forKey:pUsb];
        }
        if ([pNewDict count])
            pNewObj = pNewDict;
        else
        {
            return nil;
        }
    }
    else if ([pObj isKindOfClass:[NSArray class]])
    {
        NSArray* pAry = pObj;
        
        NSMutableArray* pNewAry = [NSMutableArray arrayWithCapacity:[pAry count]];
        
        for (id pUsb in pAry)
        {
            id pNewSub = [self DeepConvret:pUsb];
            if (pNewSub)
                [pNewAry addObject:pNewSub];
        }
        if ([pNewAry count])
        {
            pNewObj = pNewAry;
        }
        else
        {
            return nil;
        }
    }
    else if ([pObj isKindOfClass:[NSNumber class]])
    {
        pNewObj = [NSString stringWithFormat:@"%@", pObj];
    }
    else if ([pObj isKindOfClass:[NSNull class]])
    {
        return nil;
    }
    return pNewObj;
}


- (id)JSONValue
{
    SBJsonParser *jsonParser = [SBJsonParser new];
    id repr = [jsonParser objectWithString:self];
    if (!repr)
        NSLog(@"-JSONValue failed. Error trace is: %@", [jsonParser errorTrace]);
    [jsonParser release];
    return [self DeepConvret:repr];
}

- (id)__JSONValue
{
    SBJsonParser *jsonParser = [SBJsonParser new];
    id repr = [jsonParser objectWithString:self];
    if (!repr)
        NSLog(@"-JSONValue failed. Error trace is: %@", [jsonParser errorTrace]);
    [jsonParser release];
    return repr;
}


@end
