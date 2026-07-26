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

    use SheetIO.Usermodel.{Sheet}
    use SheetIO.Usermodel.ReadWorkbook



    pub def foldSheets(f: (Sheet, st) -> st \ ef, 
                        state: st): Result[String, st] \ ReadWorkbook + ef = region rc {
        let iter = ReadWorkbook.sheetIterator(rc);
        @Tailrec
        def loop(st) = match Iterator.next(iter) {
            case None => Ok(st)
            case Some(sheet) => { let st1 = f(sheet, st); loop(st1) }
        };
        loop(state)
    }   

}
