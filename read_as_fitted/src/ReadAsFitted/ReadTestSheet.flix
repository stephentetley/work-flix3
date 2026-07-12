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
    use SheetIOExtras.{getCellStringValue, addr}


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
        ?TODO

        // {
        //     var cableNum = ws.Cell(10, col).GetString();
        //     var fedFrom = ws.Cell(11, col).GetString();
        //     var circuitRefAndPhase = ws.Cell(12, col).GetString();
            
        //     if (cableNum == "" && fedFrom == "" && circuitRefAndPhase == "")
        //     {
        //         return null;
        //     } 
        //     else
        //     {
        //         return new AsFittedCircuit
        //         (
        //             FileName: header.FileName, 
        //             TabName: header.TabName, 
        //             ChecklistYear: header.ChecklistDate.HasValue ? header.ChecklistDate.Value.Year : 1970,
        //             SiteName: header.SiteName,
        //             DbOrPanelNumber: header.DbOrPanelNumber, 
        //             HeaderTestDate: header.TestDate, 
        //             SheetNumber: header.SheetNumber, 
        //             AibRef: header.AibRef,
        //             TpOrSp: header.TpOrSp,
        //             Location: header.Location, 
        //             DbOrPanelIncomerDetails: header.DbOrPanelIncomerDetails,
        //             CircuitColumn: col,
        //             CableNum: cableNum, 
        //             FedFrom: fedFrom, 
        //             CircuitRefAndPhase: circuitRefAndPhase,
        //             CircuitDescription: ws.Cell(13, col).GetString(),
        //             CircuitType: ws.Cell(14, col).GetString(),
        //             CableType: ws.Cell(15, col).GetString(),
        //             InstallationMethod: ws.Cell(16, col).GetString(), 
        //             CableLength: ws.Cell(17, col).GetString(),
        //             NumOfCoresCSA: ws.Cell(18, col).GetString(),
        //             CircuitBreakerOrFuseRating: ws.Cell(26, col).GetString(),
        //             CircuitBreakerBSAndTypeNum: ws.Cell(27, col).GetString(),
        //             CircuitBreakerManufacturerAndRefNum: ws.Cell(28, col).GetString(),
        //             RCDManufacturerAndType: ws.Cell(31, col).GetString(),
        //             Load: ws.Cell(34, col).GetString(),
        //             RatingKW: ws.Cell(35, col).GetString(),
        //             FullLoadCurrentA: ws.Cell(36, col).GetString(),
        //             CircuitVoltageV: ws.Cell(58, col).GetString(),
        //             CircuitCurrentA: ws.Cell(59, col).GetString(),
        //             TestDate: ws.Cell(60, col).GetString(),
        //             Comments: ws.Cell(61, col).GetString()
        //         );
        //     }
        // }

        def readOldFormatCircuit(col: String, header: TestHeader): Option[RawAsFittedCircuit] \ Sheet =
            ?TODO
        // {
        //     var cableNum = ws.Cell(6, col).GetString();
        //     var fedFrom = ws.Cell(7, col).GetString();
        //     var circuitRefAndPhase = ws.Cell(8, col).GetString();
            
        //     if (cableNum == "" && fedFrom == "" && circuitRefAndPhase == "")
        //     {
        //         return null;
        //     } 
        //     else
        //     {
        //         return new AsFittedCircuit
        //         (
        //             FileName: header.FileName, 
        //             TabName: header.TabName, 
        //             ChecklistYear: header.ChecklistDate.HasValue ? header.ChecklistDate.Value.Year : 1970,
        //             SiteName: header.SiteName,
        //             DbOrPanelNumber: header.DbOrPanelNumber, 
        //             HeaderTestDate: header.TestDate, 
        //             SheetNumber: header.SheetNumber, 
        //             AibRef: header.AibRef,
        //             TpOrSp: header.TpOrSp,
        //             Location: header.Location, 
        //             DbOrPanelIncomerDetails: header.DbOrPanelIncomerDetails,
        //             CircuitColumn: col,
        //             CableNum: cableNum, 
        //             FedFrom: fedFrom, 
        //             CircuitRefAndPhase: circuitRefAndPhase,
        //             CircuitDescription: ws.Cell(9, col).GetString(),
        //             CircuitType: ws.Cell(10, col).GetString(),
        //             CableType: ws.Cell(11, col).GetString(),
        //             InstallationMethod: ws.Cell(12, col).GetString(), 
        //             CableLength: ws.Cell(13, col).GetString(),
        //             NumOfCoresCSA: ws.Cell(14, col).GetString(),
        //             CircuitBreakerOrFuseRating: ws.Cell(22, col).GetString(),
        //             CircuitBreakerBSAndTypeNum: ws.Cell(23, col).GetString(),
        //             CircuitBreakerManufacturerAndRefNum: ws.Cell(24, col).GetString(),
        //             RCDManufacturerAndType: ws.Cell(27, col).GetString(),
        //             Load: ws.Cell(30, col).GetString(),
        //             RatingKW: ws.Cell(31, col).GetString(),
        //             FullLoadCurrentA: ws.Cell(32, col).GetString(),
        //             CircuitVoltageV: ws.Cell(56, col).GetString(),
        //             CircuitCurrentA: ws.Cell(57, col).GetString(),
        //             TestDate: ws.Cell(58, col).GetString(),
        //             Comments: ws.Cell(59, col).GetString()
        //         );
        //     }
        // }



}