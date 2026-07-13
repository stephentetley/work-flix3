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

use SheetIO.Usermodel.Workbook.Workbook

use Util.Json

pub def main(): Unit \ IO = 
    println("ReadAsFitted");
    let path = "../../test_data/as_fitted/test1_as_fitted.xlsx";
    let outpath = Interop.Path.swapExtension("json", path);
    println(outpath);
    SheetIOExtras.setMinInflateRatio(-1.0f64);
    let payload = run { 
            let checklistDate = ReadAsFitted.ReadGeneralChecklist.getCheckListDateString();
            let n = Workbook.getNumberOfSheets();
            println("Number of sheets: ${n}");
            Workbook.foldSheets(ac -> {
                let ans = ReadAsFitted.ReadTestSheet.parseTestSheet(path, checklistDate);
                let ans1 = List.map(ReadAsFitted.Base.circuitToJson, ans);
                ac ::: ans1
            }, Nil) |> Result.map(ToJson.toJson)
        } with SheetIO.Usermodel.Workbook.runReadOnlyXssf(path, None);   
        match Result.flatten(payload) {
            case Ok(json) => {
                let str = Util.Json.toPrettyString(4, json);
                println(str)
            }
            case Err(msg) => println("Error: ${msg}")
        } 
