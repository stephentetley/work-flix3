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
    
    use SheetIO.Usermodel.Sheet
    use SheetIO.Common.CellAddress
    use ReadAsFitted.Base.{TestHeader, RawAsFittedCircuit}
    use SheetIOExtras.{getCellStringValue, addr, cs_r}


    pub def parseTestSheet(fileName: String, checklistDate: String): List[RawAsFittedCircuit] \ Sheet = 
        let isTestSheet = getCellStringValue(addr("F1")) == "TEST SHEET";
        let isOldFormat = getCellStringValue(addr("B2")) == "Site Name:" and getCellStringValue(addr("B5")) == "CIRCUIT/CABLE DETAILS";
        let columns = List#{ "C", "D", "E", "F", "G", "H", "I", "J", "K"};
        if (isTestSheet) {
            let header = if(isOldFormat) readOldFormatHeader(fileName, checklistDate) else readHeader(fileName, checklistDate);
            List.filterMap(col -> 
                    if (isOldFormat) readOldFormatCircuit(col, header) else readCircuit(col, header),
                columns)
        } else List#{}

    pub def readHeader(fileName: String, checklistDate: String): TestHeader \ Sheet = 
        let tabName = Sheet.getSheetName();
        let siteName = getCellStringValue(addr("B3"));
        let dbOrPanelNumber = getCellStringValue(addr("E3"));
        let testDate = getCellStringValue(addr("J3"));
        let sheetNumber = getCellStringValue(addr("K3"));
        let aibRef = getCellStringValue(addr("B5"));
        let hasTpOrSp = getCellStringValue(addr("E4")) == "TP / SP";
        let tpOrSp = if (hasTpOrSp) getCellStringValue(addr("E5")) else "";
        let locationCell = if (hasTpOrSp) addr("F5") else addr("E5");
        let location = if (hasTpOrSp) getCellStringValue(locationCell) else getCellStringValue(addr("E5"));
        let dbOrPanelIncomerDetails = getCellStringValue(addr("B7"));
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
        

    pub def readOldFormatHeader(fileName: String, checklistDate: String): TestHeader \ Sheet = 
        let tabName = Sheet.getSheetName();
        let siteName = getCellStringValue(addr("B3"));
        let dbOrPanelNumber = "";
        let testDate = getCellStringValue(addr("J3"));
        let sheetNumber = getCellStringValue(addr("K3"));
        let aibRef = getCellStringValue(addr("E5"));
        let tpOrSp = "";
        let location = getCellStringValue(addr("F3"));
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
 
    def readCircuit(col: String, header: TestHeader): Option[RawAsFittedCircuit] \ Sheet = 
        let cableNum = getCellStringValue(cs_r(col, 10));
        let fedFrom = getCellStringValue(cs_r(col, 11));
        let circuitRefAndPhase = getCellStringValue(cs_r(col, 12));
            
        if (cableNum == "" and fedFrom == "" and circuitRefAndPhase == "")
            None
        else
            Some({
                +circuitColumn = col,
                +cableNum = cableNum, 
                +fedFrom = fedFrom, 
                +circuitRefAndPhase = circuitRefAndPhase,
                +circuitDescription = getCellStringValue(cs_r(col, 13)),
                +circuitType = getCellStringValue(cs_r(col, 14)),
                +cableType = getCellStringValue(cs_r(col, 15)),
                +installationMethod = getCellStringValue(cs_r(col, 16)), 
                +cableLength = getCellStringValue(cs_r(col, 17)),
                +numOfCoresCSA = getCellStringValue(cs_r(col, 18)),
                +circuitBreakerOrFuseRating = getCellStringValue(cs_r(col, 26)),
                +circuitBreakerBSAndTypeNum = getCellStringValue(cs_r(col, 27)),
                +circuitBreakerManufacturerAndRefNum = getCellStringValue(cs_r(col, 28)),
                +rcdManufacturerAndType = getCellStringValue(cs_r(col, 31)),
                +load = getCellStringValue(cs_r(col, 34)),
                +ratingKW = getCellStringValue(cs_r(col, 35)),
                +fullLoadCurrentA = getCellStringValue(cs_r(col, 36)),
                +circuitVoltageV = getCellStringValue(cs_r(col, 58)),
                +circuitCurrentA = getCellStringValue(cs_r(col, 59)),
                +testDate = getCellStringValue(cs_r(col, 60)),
                +comments = getCellStringValue(cs_r(col, 61))
                | header
            })

        def readOldFormatCircuit(col: String, header: TestHeader): Option[RawAsFittedCircuit] \ Sheet =
            let cableNum = getCellStringValue(cs_r(col, 6));
            let fedFrom = getCellStringValue(cs_r(col, 7));
            let circuitRefAndPhase = getCellStringValue(cs_r(col, 8));
            
            if (cableNum == "" and fedFrom == "" and circuitRefAndPhase == "")
                None
            else
                Some({
                    +circuitColumn = col,
                    +cableNum = cableNum, 
                    +fedFrom = fedFrom, 
                    +circuitRefAndPhase = circuitRefAndPhase,
                    +circuitDescription = getCellStringValue(cs_r(col, 9)),
                    +circuitType = getCellStringValue(cs_r(col, 10)),
                    +cableType = getCellStringValue(cs_r(col, 11)),
                    +installationMethod = getCellStringValue(cs_r(col, 12)), 
                    +cableLength = getCellStringValue(cs_r(col, 13)),
                    +numOfCoresCSA = getCellStringValue(cs_r(col, 14)),
                    +circuitBreakerOrFuseRating = getCellStringValue(cs_r(col, 22)),
                    +circuitBreakerBSAndTypeNum = getCellStringValue(cs_r(col, 23)),
                    +circuitBreakerManufacturerAndRefNum = getCellStringValue(cs_r(col, 24)),
                    +rcdManufacturerAndType = getCellStringValue(cs_r(col, 27)),
                    +load = getCellStringValue(cs_r(col, 30)),
                    +ratingKW = getCellStringValue(cs_r(col, 31)),
                    +fullLoadCurrentA = getCellStringValue(cs_r(col, 32)),
                    +circuitVoltageV = getCellStringValue(cs_r(col, 56)),
                    +circuitCurrentA = getCellStringValue(cs_r(col, 57)),
                    +testDate = getCellStringValue(cs_r(col, 58)),
                    +comments = getCellStringValue(cs_r(col, 59))
                    | header
            })


}