use Abort.runWithIO
use Fs.FileWrite
use Util.Json.ToJson
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

use SheetIO.Usermodel.ReadWorkbook.ReadWorkbook

use Util.Json

pub def main(): Unit \ IO + FileWrite = 
    println("ReadAsFitted");
    let path = "../../test_data/as_fitted/test1_as_fitted.xlsx";
    let filename = Interop.Path.getFileName(path) |> Option.getWithDefault("[error]"); 
    let outpath = Interop.Path.swapExtension("json", path);
    println(outpath);
    let payload = run { 
            let checklistDate = ReadAsFitted.ReadGeneralChecklist.getCheckListDateString();
            let n = ReadWorkbook.getNumberOfSheets();
            println("Number of sheets: ${n}");
            SheetIOExtras.foldSheets((sheet, ac) -> {
                match SheetIO.Usermodel.ReadSheet.runReadSheetWithResult(sheet, _ -> ReadAsFitted.ReadTestSheet.parseTestSheet(filename, checklistDate)) {
                    case Err(_) => ac
                    case Ok(ans) => {
                        let ans1 = List.map(ReadAsFitted.Base.circuitToJson, ans);
                        ac ::: ans1
                    }
                }
            }, Nil) |> Result.map(ToJson.toJson)
        } with SheetIO.Usermodel.ReadWorkbook.runReadWorkbookXssf(path, Some(-1.0f64));   
        match (Result.flatten(payload), outpath) {
            case (Ok(json), Some(outp)) => {
                let str = Util.Json.toPrettyString(4, json);
                discard runWithIO(_ -> FileWrite.write(str = str, outp));
                println("Wrote: ${outp}")
            }
            case (Err(msg), _) => println("Error: ${msg}")
            case (_, None) => println("Bad outpath")
        } 
