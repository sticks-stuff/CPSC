class com.clubpenguin.boot.EnvironmentData
{
   var language = "";
   var fieldOp = "";
   var basePath = "";
   var clientPath = "";
   var contentPath = "";
   var gamesPath = "";
   var username = "";
   var password = "";
   var isUsingBuildLoader = false;
   var connectionID = "testConnectionID";
   function EnvironmentData()
   {
   }
   function update(bootData)
   {
      this.language = bootData.language;
      this.affiliateID = bootData.affiliateID;
      this.promotionID = bootData.promotionID;
      this.fieldOp = bootData.fieldOp;
      this.basePath = bootData.basePath;
      this.clientPath = bootData.clientPath;
      this.contentPath = bootData.contentPath;
      this.gamesPath = bootData.gamesPath;
   }
   function setEnvironmentDataFromObject(obj)
   {
      this.language = obj.lang;
      this.affiliateID = obj.a;
      this.promotionID = obj.p;
      this.fieldOp = obj.field_op;
      this.basePath = obj.base;
      this.clientPath = obj.client;
      this.contentPath = obj.content;
      this.gamesPath = obj.games;
   }
   function getBasePath()
   {
      return this.basePath;
   }
   function getClientPath()
   {
      return this.basePath + this.clientPath;
   }
   function getGamesPath()
   {
      return this.basePath + this.gamesPath;
   }
   function getContentPath()
   {
      return this.basePath + this.contentPath;
   }
   function getGlobalContentPath()
   {
      return this.basePath + this.contentPath + "global/";
   }
   function getLocalContentPath()
   {
      return this.basePath + this.contentPath + "local/" + this.language + "/";
   }
}
