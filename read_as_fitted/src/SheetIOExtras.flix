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

    use SheetIO.Usermodel.Sheet
    use SheetIO.Common.CellAddress

    import java.lang.{Exception => JException}
    import java.lang.{IllegalArgumentException => JIllegalArgumentException}
    import org.apache.poi.openxml4j.util.{ZipSecureFile => JZipSecureFile}
    import org.apache.poi.ss.util.{WorkbookUtil => JWorkbookUtil}

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
    pub def getCellStringValue(cellAddr: CellAddress): String \ Sheet = 
        Sheet.getStringCellValue(cellAddr) |> Option.getWithDefault("")



    pub def validateSheetName(s: String): Bool = 
        try {
            let _ = unsafe IO { JWorkbookUtil.validateSheetName(s) };
            true
        } catch {
            case _: JIllegalArgumentException => false
        }


    pub def createSafeSheetName(s: String): Result[String, String] = 
        try {
            let ans = unsafe IO { JWorkbookUtil.createSafeSheetName(s) };
            Ok(ans)
        } catch {
            case _: JIllegalArgumentException => Err("")
        }

}