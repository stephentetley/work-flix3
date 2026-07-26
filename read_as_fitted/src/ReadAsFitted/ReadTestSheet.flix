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

pub mod ReadAsFitted.ReadTestSheet {
    
    use EffectExtras.Alt
    use SheetIO.Usermodel.ReadSheet
    use SheetIO.Common.CellAddress
    use SheetIO.Common.CellAddress.ToCellAddress
    use ReadAsFitted.Base.{TestHeader, RawAsFittedCircuit}
    


    pub def parseTestSheet(fileName: String, checklistDate: String): List[RawAsFittedCircuit] \ ReadSheet + Alt = 
        let isTestSheet = SheetIO.Usermodel.ReadSheet.getCellValueString("F1") == "TEST SHEET";
        let isOldFormat = SheetIO.Usermodel.ReadSheet.getCellValueString("B2") == "Site Name:" and SheetIO.Usermodel.ReadSheet.getCellValueString("B5") == "CIRCUIT/CABLE DETAILS";
        let columns = List#{"C", "D", "E", "F", "G", "H", "I", "J", "K"};
        if (isTestSheet) {
            let header = if(isOldFormat) readOldFormatHeader(fileName, checklistDate) else readHeader(fileName, checklistDate);
            List.filterMap(col -> 
                    if (isOldFormat) readOldFormatCircuit(col, header) else readCircuit(col, header),
                columns)
        } else List#{}

    pub def readHeader(fileName: String, checklistDate: String): TestHeader \ ReadSheet + Alt = 
        let tabName = ReadSheet.getSheetName();
        let siteName = SheetIO.Usermodel.ReadSheet.getCellValueString("B3") ;
        let dbOrPanelNumber = SheetIO.Usermodel.ReadSheet.getCellValueString("E3");
        let testDate = SheetIO.Usermodel.ReadSheet.getCellValueString("J3");
        let sheetNumber = SheetIO.Usermodel.ReadSheet.getCellValueString("K3");
        let aibRef = SheetIO.Usermodel.ReadSheet.getCellValueString("B5");
        let hasTpOrSp = SheetIO.Usermodel.ReadSheet.getCellValueString("E4") == "TP / SP";
        let tpOrSp = if (hasTpOrSp) SheetIO.Usermodel.ReadSheet.getCellValueString("E5") else "";
        let locationCell = if (hasTpOrSp) "F5" else "E5";
        let location = if (hasTpOrSp) SheetIO.Usermodel.ReadSheet.getCellValueString(locationCell) else SheetIO.Usermodel.ReadSheet.getCellValueString("E5");
        let dbOrPanelIncomerDetails = SheetIO.Usermodel.ReadSheet.getCellValueString("B7");
        {
            fileName = fileName,
            tabName = tabName,
            checklistDate = checklistDate,
            siteName = siteName,
            dbOrPanelNumber = dbOrPanelNumber,
            headerTestDate = testDate,
            sheetNumber = sheetNumber,
            aibRef = aibRef,
            tpOrSp = tpOrSp,
            location = location,
            dbOrPanelIncomerDetails = dbOrPanelIncomerDetails
        }
        

    pub def readOldFormatHeader(fileName: String, checklistDate: String): TestHeader \ ReadSheet + Alt = 
        let tabName = ReadSheet.getSheetName();
        let siteName = SheetIO.Usermodel.ReadSheet.getCellValueString("B3");
        let dbOrPanelNumber = "";
        let testDate = SheetIO.Usermodel.ReadSheet.getCellValueString("J3");
        let sheetNumber = SheetIO.Usermodel.ReadSheet.getCellValueString("K3");
        let aibRef = SheetIO.Usermodel.ReadSheet.getCellValueString("E5");
        let tpOrSp = "";
        let location = SheetIO.Usermodel.ReadSheet.getCellValueString("F3");
        let dbOrPanelIncomerDetails = "";
        {
            fileName = fileName,
            tabName = tabName,
            checklistDate = checklistDate,
            siteName = siteName,
            dbOrPanelNumber = dbOrPanelNumber,
            headerTestDate = testDate,
            sheetNumber = sheetNumber,
            aibRef = aibRef,
            tpOrSp = tpOrSp,
            location = location,
            dbOrPanelIncomerDetails = dbOrPanelIncomerDetails
        }
 
    def readCircuit(col: String, header: TestHeader): Option[RawAsFittedCircuit] \ ReadSheet + Alt = 
        def addr(row) = "${col}${row}";
        let cableNum = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(10));
        let fedFrom = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(11));
        let circuitRefAndPhase = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(12));
            
        if (cableNum == "" and fedFrom == "" and circuitRefAndPhase == "")
            None
        else
            Some({
                +circuitColumn = col,
                +cableNum = cableNum, 
                +fedFrom = fedFrom, 
                +circuitRefAndPhase = circuitRefAndPhase,
                +circuitDescription = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(13)),
                +circuitType = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(14)),
                +cableType = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(15)),
                +installationMethod = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(16)), 
                +cableLength = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(17)),
                +numOfCoresCSA = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(18)),
                +circuitBreakerOrFuseRating = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(26)),
                +circuitBreakerBSAndTypeNum = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(27)),
                +circuitBreakerManufacturerAndRefNum = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(28)),
                +rcdManufacturerAndType = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(31)),
                +load = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(34)),
                +ratingKW = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(35)),
                +fullLoadCurrentA = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(36)),
                +circuitVoltageV = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(58)),
                +circuitCurrentA = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(59)),
                +testDate = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(60)),
                +comments = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(61))
                | header
            })

        def readOldFormatCircuit(col: String, header: TestHeader): Option[RawAsFittedCircuit] \ ReadSheet + Alt =
            def addr(row) = "${col}${row}";
            let cableNum = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(6));
            let fedFrom = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(7));
            let circuitRefAndPhase = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(8));
            
            if (cableNum == "" and fedFrom == "" and circuitRefAndPhase == "")
                None
            else
                Some({
                    +circuitColumn = col,
                    +cableNum = cableNum, 
                    +fedFrom = fedFrom, 
                    +circuitRefAndPhase = circuitRefAndPhase,
                    +circuitDescription = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(9)),
                    +circuitType = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(10)),
                    +cableType = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(11)),
                    +installationMethod = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(12)), 
                    +cableLength = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(13)),
                    +numOfCoresCSA = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(14)),
                    +circuitBreakerOrFuseRating = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(22)),
                    +circuitBreakerBSAndTypeNum = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(23)),
                    +circuitBreakerManufacturerAndRefNum = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(24)),
                    +rcdManufacturerAndType = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(27)),
                    +load = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(30)),
                    +ratingKW = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(31)),
                    +fullLoadCurrentA = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(32)),
                    +circuitVoltageV = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(56)),
                    +circuitCurrentA = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(57)),
                    +testDate = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(58)),
                    +comments = SheetIO.Usermodel.ReadSheet.getCellValueString(addr(59))
                    | header
            })


}