// Copyright 2026 Stephen Tetley
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//   http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.


pub mod SheetIOExtras {
    use ToFlix.toFlix
    use SheetIOExtras.alt_fromOption
    use SheetIO.Usermodel.ReadWorkbook

    use EffectExtras.Alt
    use SheetIO.Usermodel.{Cell}
    use SheetIO.Usermodel.ReadWorkbook
    use SheetIO.Usermodel.ReadSheet
    use SheetIO.Usermodel.ReadCell.ReadCell
    use SheetIO.Common.CellAddress
    use SheetIO.Common.CellReference

    import java.lang.{Exception => JException}
    import java.lang.{IllegalArgumentException => JIllegalArgumentException}
    import org.apache.poi.openxml4j.util.{ZipSecureFile => JZipSecureFile}
    import org.apache.poi.ss.util.{WorkbookUtil => JWorkbookUtil}
    import org.apache.poi.ss.util.{CellAddress => JCellAddress}

    pub def setMinInflateRatio(ratio: Float64): Unit \ IO = 
        JZipSecureFile.setMinInflateRatio(ratio)

    // CellAddress.addr("B14")
    // CellAddress.r_ci(1, 2)
    // CellAddress.ci_r(2, 14)
    // CellAddress.cs_r("B", 14)

    pub def addr(s: String): CellAddress = CellAddress.createFromString(s)
    pub def r_ci(r: Int32, c: Int32): CellAddress = CellAddress.create(r, c)
    pub def ci_r(c: Int32, r: Int32): CellAddress = CellAddress.create(r, c)
    pub def cs_r(c: String, r: Int32): CellAddress = CellAddress.createFromString("${c}${r}")



    /// SheetIO TODO - must make this simple
    pub def getCellStringValue(cellAddr: CellAddress): String \ ReadSheet + Alt = 
        let cell = ReadSheet.getCell(cellAddr);
        SheetIO.Usermodel.ReadCell.runReadCell(cell, _ -> ReadCell.getCellValueString() |> String.trim)

    pub def getCellByReference(cr: CellReference): Cell \ ReadWorkbook + Alt = 
        let sheetname = CellReference.getSheetName(cr) |> alt_fromOption;
        let sheet = ReadWorkbook.getSheet(sheetname);
        let celladdr = cellReference_toCellAddress(cr);
        SheetIO.Usermodel.ReadSheet.runReadSheet(sheet, _ -> {
            ReadSheet.getCell(celladdr)
        })


    pub def alt_fromOption(x: Option[a]): a \ Alt = match x {
        case Some(a)    => a 
        case None       => Alt.failure("fromOption - Some")
    }

    pub def cellReference_toCellAddress(cr: CellReference): CellAddress = 
        let cr1 = ToJava.toJava(cr);
        let ans = unsafe IO { new JCellAddress(cr1) };
        ToFlix.toFlix(ans)
}