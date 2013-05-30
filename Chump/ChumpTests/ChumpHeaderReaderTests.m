/*
 * Copyright (c) 2013, Creeaaakk Ware
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *     * Redistributions of source code must retain the above copyright
 *       notice, this list of conditions and the following disclaimer.
 *     * Redistributions in binary form must reproduce the above copyright
 *       notice, this list of conditions and the following disclaimer in the
 *       documentation and/or other materials provided with the distribution.
 *     * Neither the name of Creeaaakk Ware nor the
 *       names of its contributors may be used to endorse or promote products
 *       derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "ChumpHeaderReaderTests.h"

@implementation ChumpHeaderReaderTests

- (void)testInit
{
    STAssertThrows([[[ChumpHeaderReader alloc] init] class], nil);
}

- (void)testInitWithInput
{
    uint8_t bytes[] = {0, 0, 0, 1, 0, 2};
    NSData * data = [NSData dataWithBytes:bytes length:6];
    STAssertThrows([[[ChumpHeaderReader alloc] initWithInput:nil] class], nil);
    STAssertNoThrow([[[ChumpHeaderReader alloc] initWithInput:[NSInputStream inputStreamWithData:data]] class], nil);
}

- (void)testRead
{
    uint8_t bytes[] = {0, 0, 0, 1, 0, 2};
    NSInputStream *input = [NSInputStream inputStreamWithData:[NSData dataWithBytes:bytes length:6]];
    [input open];
    ChumpHeaderReader *reader = [ChumpHeaderReader readerWithInput:input];
    ChumpHeader *header = [reader read];
    STAssertNotNil(header, nil);
    STAssertEquals((short) 0, header.version, nil);
    STAssertEquals((short) 1, header.messageType, nil);
    STAssertEquals((short) 2, header.tag, nil);
}

@end
