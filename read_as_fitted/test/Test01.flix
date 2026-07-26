pub mod Test01 {

    use SheetIO.Common.WorkbookUtil

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
    

    // @Test
    // def parseLocalDate02(): Unit \ Assert + IO = 
    //     let ans = SheetIOExtras.parseLocalDate("12 Feb 2022");
    //     println(ans);
    //     Assert.assertEq(expected = 0, 0)

}

