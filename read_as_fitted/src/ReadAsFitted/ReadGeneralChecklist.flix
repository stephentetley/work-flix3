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

    use EffectExtras.Alt.Alt
    use EffectExtras.Fail.Fail
    use SheetIO.Usermodel.ReadWorkbook
    use SheetIO.Usermodel.ReadCell
    use SheetIO.Common.CellReference
    use SheetIOExtras.{getCellStringValue, addr, cs_r}

    pub def getCheckListDateString(): String \ ReadWorkbook + Fail - Alt = 
        run {
            let cellref = CellReference.createFromString("'General Checklist'!B8");
            let cell = SheetIOExtras.getCellByReference(cellref);
            SheetIO.Usermodel.ReadCell.runReadCell(cell, ReadCell.getCellValueString)
        } with EffectExtras.Alt.runWithFail


}
