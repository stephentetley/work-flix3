pub mod Test01 {

    use SheetIO.Common.WorkbookUtil
    use SheetIO.Common.CellReference
    use SheetIO.Common.CellAddress

    @Test
    def createSafeSheetName01(): Unit \ Assert + IO = 
        let ans = WorkbookUtil.createSafeSheetName("");
        println(ans);
        Assert.assertEq(expected = Ok("empty"), ans)
    
    @Test
    def createSafeSheetName02(): Unit \ Assert + IO = 
        let ans = WorkbookUtil.createSafeSheetName("**Sheet 2**");
        println(ans);
        Assert.assertEq(expected = Ok("  Sheet 2  "), ans)
    
    @Test
    def cellReference01(): Unit \ Assert + IO = 
        let ans = CellReference.createFromString("'General Checklist'!B8");
        println(ans);
        Assert.assertEq(expected = 1i16, CellReference.getCol(ans))

    @Test
    def cellAddress01(): Unit \ Assert + IO = 
        let ans = CellAddress.createFromString("B8");
        println(ans);
        Assert.assertEq(expected = 1, CellAddress.getColumn(ans))


    // @Test
    // def parseLocalDate02(): Unit \ Assert + IO = 
    //     let ans = SheetIOExtras.parseLocalDate("12 Feb 2022");
    //     println(ans);
    //     Assert.assertEq(expected = 0, 0)

}

