var AWS = require("aws-sdk");
var dynamodb = new AWS.DynamoDB();
// dynamodb.AWS.config.update({region: "us-east-1"});

exports.handler = function(event, context) {
	let readingTypes = ["BP", "WEIGHT", "SPO2"];
	var year = 2020;
	createReadingTables(readingTypes, year);

}
function createReadingTables(readingTypes, year) {
	for (let index = 0; index < readingTypes.length; ++index) {
		var currentType = readingTypes[index];
		var tableName = "READINGS_" + currentType + "_" + year;
		createReadingTable(tableName);
	}
}
function createReadingTable(tableName) {
	console.log(tableName);
 var params = {
  AttributeDefinitions: [
  {
    AttributeName: "UserId", 
    AttributeType: "S"
   }, 
     {
    AttributeName: "ReadingTakenTime", 
    AttributeType: "N"
   }
	/*,
   {
    AttributeName: "MeasurementTypes", 
    AttributeType: "S"
   }, 
     {
    AttributeName: "SensorId", 
    AttributeType: "S"
   },
     {
    AttributeName: "UnattributedReading", 
    AttributeType: "S"
   }*/
  ], 
  KeySchema: [
     {
    AttributeName: "UserId", 
    KeyType: "HASH"
   }, 
     {
    AttributeName: "ReadingTakenTime", 
    KeyType: "RANGE"
   }
  ], 
  ProvisionedThroughput: {
   ReadCapacityUnits: 5, 
   WriteCapacityUnits: 5
  }, 
  TableName: tableName
 };
 dynamodb.createTable(params, function(err, data) {
	if(err) {
		console.log("error creating " + tableName);
		console.log(JSON.stringify(err));
	} else {
		console.log("created " + tableName);
	}
  });
}
