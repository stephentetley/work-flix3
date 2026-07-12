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

pub mod ReadAsFitted.Base {

    use Util.Json
    use Util.Json.Json.{JObject}
    use Util.Json.ToJson

    pub type alias TestHeader[r: RecordRow] = {
        fileName = String,
        tabName = String,
        checklistYear = Int32,
        siteName = String,
        dbOrPanelNumber = String,
        headerTestDate = String,
        sheetNumber = String,
        aibRef = String,
        tpOrSp = String,
        location = String,
        dbOrPanelIncomerDetails = String | r
    }

    pub type alias RawAsFittedCircuit = {
        fileName = String,
        tabName = String,
        checklistYear = Int32,
        siteName = String,
        dbOrPanelNumber = String,
        headerTestDate = String,
        sheetNumber = String,
        aibRef = String,
        tpOrSp = String,
        location = String,
        dbOrPanelIncomerDetails = String,
        circuitColumn = String,
        cableNum = String,
        fedFrom = String,
        circuitRefAndPhase = String,
        circuitDescription = String,
        circuitType = String,
        cableType = String,
        installationMethod = String,
        cableLength = String,
        numOfCoresCSA = String,
        circuitBreakerOrFuseRating = String,
        circuitBreakerBSAndTypeNum = String,
        circuitBreakerManufacturerAndRefNum = String,
        rcdManufacturerAndType = String,
        load = String,
        ratingKW = String,
        fullLoadCurrentA = String,
        circuitVoltageV = String,
        circuitCurrentA = String,
        testDate = String,
        comments = String
    }

    pub def toJson(x: RawAsFittedCircuit): Json = 
        JObject(Map#{
            "file_name" => ToJson.toJson(x#fileName),
            "sheet_name" => ToJson.toJson(x#tabName),
            "checklist_year" => ToJson.toJson(x#checklistYear),
            "site_name" => ToJson.toJson(x#siteName),
            "db_or_panel_number" => ToJson.toJson(x#dbOrPanelNumber),
            "header_test_date" => ToJson.toJson(x#headerTestDate),
            "sheet_number" => ToJson.toJson(x#sheetNumber),
            "aib_ref" => ToJson.toJson(x#aibRef),
            "tp_or_sp" => ToJson.toJson(x#tpOrSp),
            "location" => ToJson.toJson(x#location),
            "db_or_panel_incomer_details" => ToJson.toJson(x#dbOrPanelIncomerDetails),
            "circuit_column" => ToJson.toJson(x#circuitColumn),
            "cable_num" => ToJson.toJson(x#cableNum),
            "fed_from" => ToJson.toJson(x#fedFrom),
            "circuit_ref_and_phase" => ToJson.toJson(x#circuitRefAndPhase),
            "circuit_description" => ToJson.toJson(x#circuitDescription),
            "circuit_type" => ToJson.toJson(x#circuitType),
            "cable_type" => ToJson.toJson(x#cableType),
            "installation_method" => ToJson.toJson(x#installationMethod),
            "cable_length" => ToJson.toJson(x#cableLength),
            "num_of_cores_csa" => ToJson.toJson(x#numOfCoresCSA),
            "circuit_breaker_or_fuse_rating" => ToJson.toJson(x#circuitBreakerOrFuseRating),
            "circuit_breaker_bs_and_type_num" => ToJson.toJson(x#circuitBreakerBSAndTypeNum),
            "circuit_breaker_manufacturer_and_ref_num" => ToJson.toJson(x#circuitBreakerManufacturerAndRefNum),
            "rcd_manufacturer_and_type" => ToJson.toJson(x#rcdManufacturerAndType),
            "load" => ToJson.toJson(x#load),
            "rating_kw" => ToJson.toJson(x#ratingKW),
            "full_load_current_a" => ToJson.toJson(x#fullLoadCurrentA),
            "circuit_voltage_v" => ToJson.toJson(x#circuitVoltageV),
            "circuit_current_a" => ToJson.toJson(x#circuitCurrentA),
            "test_date" => ToJson.toJson(x#testDate),
            "comments" => ToJson.toJson(x#comments)
        })

}