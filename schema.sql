const database = db.getSiblingDB("employee_admin_dashboard");

["user_summary","admin_activity_summary","employee_tracking","activity_logs","system_settings","users","roles","admins"].forEach(function(name){if(database.getCollectionNames().indexOf(name)!==-1){database[name].drop();}});

database.createCollection("admins",{validator:{$jsonSchema:{bsonType:"object",required:["username","email","password","created_at","updated_at"],properties:{username:{bsonType:"string",maxLength:100},email:{bsonType:"string",maxLength:255},password:{bsonType:"string",maxLength:255},role:{bsonType:["string","null"],maxLength:50},permissions:{bsonType:["array","null"],items:{bsonType:"string"}},status:{bsonType:["string","null"],maxLength:20},last_login:{bsonType:["date","null"]},created_at:{bsonType:"date"},updated_at:{bsonType:"date"}}}}});

database.createCollection("roles",{validator:{$jsonSchema:{bsonType:"object",required:["role_name","created_at","updated_at"],properties:{role_name:{bsonType:"string",maxLength:100},description:{bsonType:["string","null"]},permissions:{bsonType:["array","null"],items:{bsonType:"string"}},created_by:{bsonType:["objectId","null"]},created_at:{bsonType:"date"},updated_at:{bsonType:"date"}}}}});

database.createCollection("users",{validator:{$jsonSchema:{bsonType:"object",required:["first_name","email","status","created_at","updated_at"],properties:{first_name:{bsonType:"string",maxLength:100},last_name:{bsonType:["string","null"],maxLength:100},email:{bsonType:"string",maxLength:255},mobile:{bsonType:["string","null"],maxLength:20},alternate_id:{bsonType:["string","null"],maxLength:50},role_id:{bsonType:["objectId","null"]},status:{bsonType:"string",maxLength:20},created_by:{bsonType:["objectId","null"]},created_at:{bsonType:"date"},updated_at:{bsonType:"date"}}}}});

database.createCollection("activity_logs",{validator:{$jsonSchema:{bsonType:"object",required:["action","timestamp"],properties:{user_id:{bsonType:["objectId","null"]},action:{bsonType:"string",maxLength:255},module:{bsonType:["string","null"],maxLength:100},details:{bsonType:["object","array","null"]},ip_address:{bsonType:["string","null"],maxLength:45},timestamp:{bsonType:"date"}}}}});

database.createCollection("system_settings",{validator:{$jsonSchema:{bsonType:"object",required:["setting_name","value","updated_at"],properties:{setting_name:{bsonType:"string",maxLength:100},value:{bsonType:"string"},description:{bsonType:["string","null"]},updated_by:{bsonType:["objectId","null"]},updated_at:{bsonType:"date"}}}}});

database.createCollection("employee_tracking",{validator:{$jsonSchema:{bsonType:"object",required:["employee_id","date","status","created_at"],properties:{employee_id:{bsonType:"objectId"},date:{bsonType:"date"},check_in_time:{bsonType:["date","null"]},check_out_time:{bsonType:["date","null"]},latitude:{bsonType:["double","decimal","null"]},longitude:{bsonType:["double","decimal","null"]},status:{bsonType:"string",maxLength:20},created_at:{bsonType:"date"}}}}});

database.admins.createIndex({email:1},{unique:true});
database.admins.createIndex({username:1},{unique:true});
database.roles.createIndex({role_name:1},{unique:true});
database.users.createIndex({email:1},{unique:true});
database.activity_logs.createIndex({user_id:1});
database.system_settings.createIndex({setting_name:1},{unique:true});
database.employee_tracking.createIndex({employee_id:1});

const now=new Date();
const adminInsert=database.admins.insertOne({username:"admin",email:"admin@dashboard.com",password:"hashed_admin_password",role:"SuperAdmin",permissions:["manage_users","view_reports","edit_settings"],status:"active",last_login:null,created_at:now,updated_at:now});
const adminId=adminInsert.insertedId;
const roleInsert=database.roles.insertMany([{role_name:"Manager",description:"Can view and manage users and reports",permissions:["create_user","update_user","view_reports"],created_by:adminId,created_at:now,updated_at:now},{role_name:"Viewer",description:"Can only view dashboard data",permissions:["view_reports"],created_by:adminId,created_at:now,updated_at:now}]);
const managerRoleId=roleInsert.insertedIds["0"];
const viewerRoleId=roleInsert.insertedIds["1"];
const userInsert=database.users.insertMany([{first_name:"John",last_name:"Doe",email:"john.doe@example.com",mobile:"+919876543210",alternate_id:"A12345",role_id:managerRoleId,status:"active",created_by:adminId,created_at:now,updated_at:now},{first_name:"Jane",last_name:"Smith",email:"jane.smith@example.com",mobile:"+919876543211",alternate_id:"A12346",role_id:viewerRoleId,status:"active",created_by:adminId,created_at:now,updated_at:now}]);
const johnId=userInsert.insertedIds["0"];
const janeId=userInsert.insertedIds["1"];
database.system_settings.insertMany([{setting_name:"dashboard_theme",value:"dark",description:"Default dashboard color theme",updated_by:adminId,updated_at:now},{setting_name:"records_per_page",value:"10",description:"Default pagination limit",updated_by:adminId,updated_at:now}]);

database.createCollection("user_summary",{viewOn:"users",pipeline:[{$lookup:{from:"roles",localField:"role_id",foreignField:"_id",as:"role"}},{$unwind:{path:"$role",preserveNullAndEmptyArrays:true}},{$addFields:{full_name:{$cond:[{$or:[{$eq:["$last_name",null]},{$eq:["$last_name",""]}]},"$first_name",{$concat:["$first_name"," ","$last_name"]}]}}},{$project:{_id:0,id:"$_id",full_name:1,role_name:"$role.role_name",status:1,created_at:1}}]});

database.createCollection("admin_activity_summary",{viewOn:"admins",pipeline:[{$lookup:{from:"activity_logs",let:{adminId:"$_id"},pipeline:[{$match:{$expr:{$eq:["$user_id","$$adminId"]}}}],as:"logs"}},{$addFields:{total_actions:{$size:"$logs"},last_action_time:{$max:{$map:{input:"$logs",as:"entry",in:"$$entry.timestamp"}}}}},{$project:{_id:0,username:1,total_actions:1,last_action_time:1}}]});
