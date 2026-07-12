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

pub mod ReadAsFitted.ReadGeneralChecklist {

    use EffectExtras.Alt
    use SheetIO.Usermodel.Workbook
    use SheetIOExtras.{getCellStringValue, addr, cs_r}

    pub def getCheckListDateString(): String \ Workbook = 
        let ws = Workbook.getSheet("General Checklist");
        run { SheetIO.Usermodel.Sheet.runSheet(ws, _ -> 
            getCellStringValue(addr("B8"))
        )} with SheetIOExtras.alt_runWithDefault("1970")


}
