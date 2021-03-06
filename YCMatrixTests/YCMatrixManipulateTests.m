//
//  ManipulateTests.m
//
// Copyright (c) 2013, 2014 Ioannis (Yannis) Chatzikonstantinou. All rights reserved.
// http://yconst.com
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <XCTest/XCTest.h>
#import "Matrix.h"
#import "Matrix+Manipulate.h"

#define ARC4RANDOM_MAX 0x100000000 

// Definitions for convenience logging functions (without date/object and title logging).
#define CleanNSLog(FORMAT, ...) fprintf(stderr,"%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#define TitleNSLog(FORMAT, ...) fprintf(stderr,"\n%s\n_____________________________________\n\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

@interface YCMatrixManipulateTests : XCTestCase

@end

@implementation YCMatrixManipulateTests

- (void)testRowRetrieval
{
    TitleNSLog(@"Matrix row retrieval");
    double testmrarr[6] = { 1.0, 2.0, 3.0, 4.0, 5.0, 6.0 };
    Matrix *testmr = [Matrix matrixFromArray:testmrarr Rows:2 Columns:3];
    Matrix *rowm = [testmr row:1]; // This is being tested.
    CleanNSLog(@"%@", rowm);
    double templatermatrixarr[3] = { 4.0, 5.0, 6.0 };
    Matrix *templatemr = [Matrix matrixFromArray:templatermatrixarr Rows:1 Columns:3];
    XCTAssertTrue([rowm isEqual: templatemr], @"Matrix row retrieval is problematic.");
}

- (void)testColumnRetrieval
{
    TitleNSLog(@"Matrix column retrieval");
    double testmcarr[6] = { 1.0, 4.0, 2.0, 5.0, 3.0, 6.0 };
    Matrix *testmc = [Matrix matrixFromArray:testmcarr Rows:3 Columns:2];
    Matrix *columnm = [testmc column:1]; // This is being tested.
    CleanNSLog(@"%@", columnm);
    double templatecmatrixarr[3] = { 4.0, 5.0, 6.0 };
    Matrix *templatemc = [Matrix matrixFromArray:templatecmatrixarr Rows:3 Columns:1];
    XCTAssertTrue([columnm isEqual: templatemc], @"Matrix column retrieval is problematic.");
}

- (void)testRowsToNSArray
{
    TitleNSLog(@"Rows as NSArray");
    double rowsColumnsArrayTest[12] = { 1.0, 2.0, 3.0, 4.0,
        5.0, 6.0, 7.0, 8.0,
        9.0, 10.0, 11.0, 12.0};
    double firstRow[4] = { 1.0, 2.0, 3.0, 4.0 };
    Matrix *firstRowMatrix = [Matrix matrixFromArray:firstRow Rows:1 Columns:4];
    double secondRow[4] = { 5.0, 6.0, 7.0, 8.0 };
    Matrix *secondRowMatrix = [Matrix matrixFromArray:secondRow Rows:1 Columns:4];
    double thirdRow[4] = { 9.0, 10.0, 11.0, 12.0 };
    Matrix *thirdRowMatrix = [Matrix matrixFromArray:thirdRow Rows:1 Columns:4];
    
    Matrix *rowsColumnsTestMatrix = [Matrix matrixFromArray:rowsColumnsArrayTest Rows:3 Columns:4];
    NSArray *rowsTestRows = [rowsColumnsTestMatrix rowsAsNSArray];
    XCTAssertEqualObjects([rowsTestRows objectAtIndex:0], firstRowMatrix, @"Error in conversion to rows array(1).");
    XCTAssertEqualObjects([rowsTestRows objectAtIndex:1], secondRowMatrix, @"Error in conversion to rows array(2).");
    XCTAssertEqualObjects([rowsTestRows objectAtIndex:2], thirdRowMatrix, @"Error in conversion to rows array(3).");
}

// All code under test must be linked into the Unit Test bundle
- (void)testColumnsToNSArray
{
    TitleNSLog(@"Columns as NSArray");
    double rowsColumnsArrayTest[12] = { 1.0, 2.0, 3.0, 4.0,
        5.0, 6.0, 7.0, 8.0,
        9.0, 10.0, 11.0, 12.0};
    double firstColumn[3] = { 1.0, 5.0, 9.0 };
    Matrix *firstColumnMatrix = [Matrix matrixFromArray:firstColumn Rows:3 Columns:1];
    double secondColumn[3] = { 2.0, 6.0, 10.0 };
    Matrix *secondColumnMatrix = [Matrix matrixFromArray:secondColumn Rows:3 Columns:1];
    double thirdColumn[3] = { 3.0, 7.0, 11.0 };
    Matrix *thirdColumnMatrix = [Matrix matrixFromArray:thirdColumn Rows:3 Columns:1];
    double fourthColumn[3] = { 4.0, 8.0, 12.0 };
    Matrix *fourthColumnMatrix = [Matrix matrixFromArray:fourthColumn Rows:3 Columns:1];

    Matrix *rowsColumnsTestMatrix = [Matrix matrixFromArray:rowsColumnsArrayTest Rows:3 Columns:4];
    NSArray *columnsTestColumns = [rowsColumnsTestMatrix columnsAsNSArray];
    XCTAssertEqualObjects([columnsTestColumns objectAtIndex:0], firstColumnMatrix,
                          @"Error in conversion to columns array(1).");
    XCTAssertEqualObjects([columnsTestColumns objectAtIndex:1], secondColumnMatrix,
                          @"Error in conversion to columns array(2).");
    XCTAssertEqualObjects([columnsTestColumns objectAtIndex:2], thirdColumnMatrix,
                          @"Error in conversion to columns array(3).");
    XCTAssertEqualObjects([columnsTestColumns objectAtIndex:3], fourthColumnMatrix,
                          @"Error in conversion to columns array(4).");
}

- (void)testSubMatrices
{
    TitleNSLog(@"Sub-Matrix Extraction Test");
    double simple_array[16] = { 1.0, 2.0, 3.0, 4.0,
        5.0, 6.0, 7.0, 8.0,
        9.0, 10.0, 11.0, 12.0,
        13.0, 14.0, 15.0, 16.0 };
    Matrix *original = [Matrix matrixFromArray:simple_array Rows:4 Columns:4];
    
    double expected_rows[8] = { 5.0, 6.0, 7.0, 8.0,
        9.0, 10.0, 11.0, 12.0 };
    Matrix *expectedRows = [Matrix matrixFromArray:expected_rows Rows:2 Columns:4];
    Matrix *resultRows = [original matrixWithRowsInRange:NSMakeRange(1, 2)];
    CleanNSLog(@"%@", resultRows);
    XCTAssertEqualObjects(expectedRows, resultRows, @"Error while extracting rows to sub-matrix");
    
    double expected_columns[8] = { 2.0, 3.0,
        6.0, 7.0,
        10.0, 11.0,
        14.0, 15.0 };
    Matrix *expectedColumns = [Matrix matrixFromArray:expected_columns Rows:4 Columns:2];
    Matrix *resultColumns = [original matrixWithColumnsInRange:NSMakeRange(1, 2)];
    CleanNSLog(@"%@", resultColumns);
    XCTAssertEqualObjects(expectedColumns, resultColumns, @"Error while extracting columns to sub-matrix");
}

- (void)testRowAndColumnAdditionsSubtractions
{
    TitleNSLog(@"Row / Column Additions / Subtractions");
    double simple_array[16] = { 1.0, 2.0, 3.0, 4.0,
        5.0, 6.0, 7.0, 8.0,
        9.0, 10.0, 11.0, 12.0,
        13.0, 14.0, 15.0, 16.0 };
    Matrix *original = [Matrix matrixFromArray:simple_array Rows:4 Columns:4];
    double element[4] = { 4.0, 1.0, -40.0, -22.5 };
    Matrix *column = [Matrix matrixFromArray:element Rows:4 Columns:1];
    Matrix *row = [Matrix matrixFromArray:element Rows:1 Columns:4];
    Matrix *step1 = [original matrixByAddingRow:row];
    Matrix *step2 = [step1 matrixByAddingColumn:column];
    Matrix *step3 = [step2 matrixBySubtractingColumn:column];
    Matrix *step4 = [step3 matrixBySubtractingRow:row];
    
    XCTAssertEqualObjects(original, step4, @"Error while Adding / Subtracting Rows / Columns");
}

@end
