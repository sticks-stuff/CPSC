class com.clubpenguin.stamps.StampManager
{
   static var ALL_CATEGORY_ID = 9000;
   static var AWARD_CATEGORY_ID = 22;
   static var PIN_CATEGORY_ID = 9001;
   static var MYSTERY_CATEGORY_ID = 10000;
   static var MYSTERY_PAGE_TITLE = "Mystery Page";
   static var MAX_STAMPBOOK_COVER_ITEMS = 6;
   static var STAMP_ICON_BOX_WIDTH = 80;
   static var STAMP_ICON_BOX_HEIGHT = 70;
   static var STAMPBOOK_SWF_FILENAME = "stampbook.swf";
   static var COVER_PATTERN_NONE_ID = -1;
   static var SOCKET_SERVER_DATA_DELIMITER = "|";
   static var MILLISECONDS = 1000;
   function StampManager(shell, connection)
   {
      this.shell = shell;
      if(com.clubpenguin.stamps.StampManager.MONTH_STRING == undefined)
      {
         com.clubpenguin.stamps.StampManager.MONTH_STRING = [];
         com.clubpenguin.stamps.StampManager.MONTH_STRING.push(shell.getLocalizedString("January"));
         com.clubpenguin.stamps.StampManager.MONTH_STRING.push(shell.getLocalizedString("February"));
         com.clubpenguin.stamps.StampManager.MONTH_STRING.push(shell.getLocalizedString("March"));
         com.clubpenguin.stamps.StampManager.MONTH_STRING.push(shell.getLocalizedString("April"));
         com.clubpenguin.stamps.StampManager.MONTH_STRING.push(shell.getLocalizedString("May"));
         com.clubpenguin.stamps.StampManager.MONTH_STRING.push(shell.getLocalizedString("June"));
         com.clubpenguin.stamps.StampManager.MONTH_STRING.push(shell.getLocalizedString("July"));
         com.clubpenguin.stamps.StampManager.MONTH_STRING.push(shell.getLocalizedString("August"));
         com.clubpenguin.stamps.StampManager.MONTH_STRING.push(shell.getLocalizedString("September"));
         com.clubpenguin.stamps.StampManager.MONTH_STRING.push(shell.getLocalizedString("October"));
         com.clubpenguin.stamps.StampManager.MONTH_STRING.push(shell.getLocalizedString("November"));
         com.clubpenguin.stamps.StampManager.MONTH_STRING.push(shell.getLocalizedString("December"));
      }
      if(com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS == undefined)
      {
         com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS = [];
         com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[159] = 801;
         com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[160] = 802;
         com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[161] = 803;
         com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[162] = 804;
         com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[163] = 805;
         com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[164] = 806;
         com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[165] = 808;
         com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[166] = 809;
         com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[167] = 810;
         com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[168] = 811;
         com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[169] = 813;
         com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[170] = 814;
         com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[171] = 815;
         com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[172] = 816;
         com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[173] = 817;
         com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[174] = 818;
         com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[175] = 819;
         com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[176] = 820;
         com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[177] = 822;
         com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[178] = 823;
         com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[179] = 8007;
         com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[180] = 8008;
      }
      if(com.clubpenguin.stamps.StampManager.EPF_FIELD_OPS_NUM_MEDALS_TO_STAMP_ID == undefined)
      {
         com.clubpenguin.stamps.StampManager.EPF_FIELD_OPS_NUM_MEDALS_TO_STAMP_ID = [];
         com.clubpenguin.stamps.StampManager.EPF_FIELD_OPS_NUM_MEDALS_TO_STAMP_ID[1] = 197;
         com.clubpenguin.stamps.StampManager.EPF_FIELD_OPS_NUM_MEDALS_TO_STAMP_ID[5] = 198;
         com.clubpenguin.stamps.StampManager.EPF_FIELD_OPS_NUM_MEDALS_TO_STAMP_ID[10] = 199;
         com.clubpenguin.stamps.StampManager.EPF_FIELD_OPS_NUM_MEDALS_TO_STAMP_ID[25] = 200;
         com.clubpenguin.stamps.StampManager.EPF_FIELD_OPS_NUM_MEDALS_TO_STAMP_ID[50] = 201;
      }
      this._numClubPenguinStamps = 0;
      this.clubPenguinStampCategories = [];
      this._myStamps = [];
      this.pinCategoryName = shell.getLocalizedString("pins_category_title");
      this.stampDefinitionsParsed = new org.osflash.signals.Signal(Array,Number);
      this.stampDefinitionsParsed.addOnce(this.handleStampDefinitionsParsed,this);
      this.stampDefinitionsService = new com.clubpenguin.stamps.StampDefinitionsService(this,this.stampDefinitionsParsed,shell.getWebServiceManager());
      this._stampBookCoverCrumbs = new com.clubpenguin.stamps.StampBookCoverCrumbs(shell.getWebServiceManager());
      this.pinsService = new com.clubpenguin.services.PinsService(connection);
      this.pinsService.__get__pinsListReceived().add(this.handleQueryPlayersPins,this);
      this.awardsService = new com.clubpenguin.services.AwardsService(connection);
      this.awardsService.__get__awardsListReceived().add(this.handleQueryPlayersAwards,this);
      this.epfService = new com.clubpenguin.services.EPFService(connection);
      this.epfService.__get__pointsReceived().add(this.handleEPFPoints,this);
      this.stampsService = new com.clubpenguin.services.StampsService(connection);
      this.stampsService.__get__playersStampsReceived().add(this.handleGetPlayersStamps,this);
      this.stampsService.__get__recentlyEarnedStampsReceived().add(this.handleGetMyRecentlyEarnedStamps,this);
      this.stampsService.__get__playersStampBookCoverDetailsReceived().add(this.handleGetStampBookCoverDetails,this);
      this.stampsService.__get__playerEarnedStampReceived().add(this.handlePlayerEarnedStampReceived,this);
   }
   function destroy()
   {
      var _loc3_ = this.clubPenguinStampCategories.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc3_)
      {
         this.clubPenguinStampCategories[_loc2_].destroy();
         _loc2_ = _loc2_ + 1;
      }
      delete this.clubPenguinStampCategories;
      delete this._myStamps;
      this.pinsService.__get__pinsListReceived().remove(this.handleQueryPlayersPins,this);
      this.awardsService.__get__awardsListReceived().remove(this.handleQueryPlayersAwards,this);
      this.epfService.__get__pointsReceived().remove(this.handleEPFPoints,this);
      this.stampsService.__get__playersStampsReceived().remove(this.handleGetPlayersStamps,this);
      this.stampsService.__get__recentlyEarnedStampsReceived().remove(this.handleGetMyRecentlyEarnedStamps,this);
      this.stampsService.__get__playersStampBookCoverDetailsReceived().remove(this.handleGetStampBookCoverDetails,this);
      this.stampsService.__get__playerEarnedStampReceived().remove(this.handlePlayerEarnedStampReceived,this);
   }
   function stampItemComparisonByDifficultyThenID(stampBookItemA, stampBookItemB)
   {
      if(stampBookItemA.getType() != com.clubpenguin.stamps.StampBookItemType.STAMP || stampBookItemB.getType() != com.clubpenguin.stamps.StampBookItemType.STAMP)
      {
         return 0;
      }
      var _loc5_ = (com.clubpenguin.stamps.IStampItem)stampBookItemA;
      var _loc6_ = (com.clubpenguin.stamps.IStampItem)stampBookItemB;
      var _loc4_ = _loc5_.getDifficulty();
      var _loc3_ = _loc6_.getDifficulty();
      var _loc2_ = _loc5_.getID();
      var _loc1_ = _loc6_.getID();
      if(_loc4_ < _loc3_)
      {
         return -1;
      }
      if(_loc4_ > _loc3_)
      {
         return 1;
      }
      if(_loc2_ < _loc1_)
      {
         return -1;
      }
      if(_loc2_ > _loc1_)
      {
         return 1;
      }
      return 0;
   }
   function stampBookItemComparisonByID(stampBookItemA, stampBookItemB)
   {
      var _loc2_ = stampBookItemA.getID();
      var _loc1_ = stampBookItemB.getID();
      if(_loc2_ < _loc1_)
      {
         return -1;
      }
      if(_loc2_ > _loc1_)
      {
         return 1;
      }
      return 0;
   }
   function stampBookCategoryComparisonByID(stampBookCategoryA, stampBookCategoryB)
   {
      var _loc2_ = stampBookCategoryA.getID();
      var _loc1_ = stampBookCategoryB.getID();
      if(_loc2_ < _loc1_)
      {
         return -1;
      }
      if(_loc2_ > _loc1_)
      {
         return 1;
      }
      return 0;
   }
   function checkForEPFFieldOpsMedalStamps(totalPoints)
   {
      if(totalPoints == undefined || totalPoints == null)
      {
         this.epfService.getPoints();
      }
      else
      {
         var _loc3_ = [];
         for(var _loc2_ in com.clubpenguin.stamps.StampManager.EPF_FIELD_OPS_NUM_MEDALS_TO_STAMP_ID)
         {
            if(Number(_loc2_) <= totalPoints)
            {
               _loc3_.push(com.clubpenguin.stamps.StampManager.EPF_FIELD_OPS_NUM_MEDALS_TO_STAMP_ID[Number(_loc2_)]);
            }
         }
         var _loc4_ = _loc3_.length;
         _loc2_ = 0;
         while(_loc2_ < _loc4_)
         {
            this.shell.stampEarned(_loc3_[_loc2_]);
            _loc2_ = _loc2_ + 1;
         }
      }
   }
   function getAwardStampID(dbAwardID)
   {
      for(var _loc3_ in com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS)
      {
         var _loc1_ = Number(_loc3_);
         if(com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[_loc1_] == dbAwardID)
         {
            return _loc1_;
         }
      }
      return -1;
   }
   function setRecentlyEarnedStamp(stampID, isServerSide)
   {
      if(!isServerSide)
      {
         this.stampsService.sendStampEarned(stampID);
      }
      var _loc2_ = this.getStampBookItem(stampID,com.clubpenguin.stamps.StampBookItemType.STAMP.__get__value());
      if(_loc2_ != undefined)
      {
         this._myStamps.push(_loc2_);
      }
   }
   function __get__stampBookCoverCrumbs()
   {
      return this._stampBookCoverCrumbs;
   }
   function __get__myStamps()
   {
      return this._myStamps;
   }
   function __get__numClubPenguinStamps()
   {
      return this._numClubPenguinStamps;
   }
   function getStampBookItem(id, typeValue)
   {
      var _loc9_ = this._usersStampCategories.length;
      var _loc5_ = 0;
      while(_loc5_ < _loc9_)
      {
         var _loc2_ = this.findStampBookItemInItemsList(id,this._usersStampCategories[_loc5_].getItems(),typeValue);
         if(_loc2_ != undefined)
         {
            return _loc2_;
         }
         var _loc4_ = this._usersStampCategories[_loc5_].getSubCategories();
         if(_loc4_ != undefined)
         {
            var _loc6_ = _loc4_.length;
            var _loc3_ = 0;
            while(_loc3_ < _loc6_)
            {
               _loc2_ = this.findStampBookItemInItemsList(id,_loc4_[_loc3_].getItems(),typeValue);
               if(_loc2_ != undefined)
               {
                  return _loc2_;
               }
               _loc3_ = _loc3_ + 1;
            }
         }
         _loc5_ = _loc5_ + 1;
      }
      return undefined;
   }
   function stampIsOwnedByMe(stampID)
   {
      if(this._myStamps != undefined)
      {
         var _loc3_ = this._myStamps.length;
         var _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            if(this._myStamps[_loc2_].getID() == stampID)
            {
               return true;
            }
            _loc2_ = _loc2_ + 1;
         }
      }
      return false;
   }
   function getPlayersStampBookCategories(playerID)
   {
      this.pinsService.queryPlayersPins(playerID);
   }
   function getPlayersStamps(playerID)
   {
      this.stampsService.getPlayersStamps(playerID);
   }
   function getMyRecentlyEarnedStamps()
   {
      this.stampsService.getMyRecentlyEarnedStamps();
   }
   function getStampBookCoverDetails(playerID)
   {
      this.stampsService.getStampBookCoverDetails(playerID);
   }
   function saveMyStampBookCover(stampBookCover)
   {
      var _loc15_ = stampBookCover.getColourID();
      var _loc14_ = stampBookCover.getHighlightID();
      var _loc16_ = stampBookCover.getPatternID();
      var _loc17_ = stampBookCover.getClaspIconArtID();
      var _loc11_ = [];
      var _loc10_ = stampBookCover.getCoverItems();
      var _loc12_ = _loc10_.length;
      var _loc4_ = 0;
      while(_loc4_ < _loc12_)
      {
         var _loc2_ = _loc10_[_loc4_];
         var _loc6_ = _loc2_.getItem();
         var _loc7_ = _loc6_.getType().__get__value();
         var _loc3_ = _loc6_.getID();
         var _loc5_ = _loc2_.getItemPosition();
         var _loc9_ = _loc2_.getItemRotation();
         var _loc8_ = _loc2_.getItemDepth();
         if(_loc7_ == com.clubpenguin.stamps.StampBookItemType.AWARD.__get__value())
         {
            _loc3_ = com.clubpenguin.stamps.StampManager.AWARD_STAMP_IDS_TO_DB_IDS[_loc3_];
         }
         _loc11_.push(_loc7_ + com.clubpenguin.stamps.StampManager.SOCKET_SERVER_DATA_DELIMITER + _loc3_ + com.clubpenguin.stamps.StampManager.SOCKET_SERVER_DATA_DELIMITER + _loc5_.x + com.clubpenguin.stamps.StampManager.SOCKET_SERVER_DATA_DELIMITER + _loc5_.y + com.clubpenguin.stamps.StampManager.SOCKET_SERVER_DATA_DELIMITER + _loc9_ + com.clubpenguin.stamps.StampManager.SOCKET_SERVER_DATA_DELIMITER + _loc8_);
         _loc4_ = _loc4_ + 1;
      }
      this.stampsService.setStampBookCoverDetails(_loc15_,_loc14_,_loc16_,_loc17_,_loc11_);
   }
   function handleEPFPoints(unusedPoints, totalPoints)
   {
      this.checkForEPFFieldOpsMedalStamps(totalPoints);
   }
   function handleQueryPlayersPins(serverEventData)
   {
      this._usersStampCategories = [];
      var _loc15_ = Number(serverEventData.shift());
      var _loc10_ = [];
      var _loc12_ = serverEventData.length;
      var _loc4_ = 0;
      while(_loc4_ < _loc12_)
      {
         var _loc3_ = serverEventData[_loc4_].split(com.clubpenguin.stamps.StampManager.SOCKET_SERVER_DATA_DELIMITER);
         var _loc7_ = Number(_loc3_[0]);
         var _loc6_ = this.shell.getInventoryObjectById(_loc7_);
         if(_loc6_ != undefined)
         {
            var _loc9_ = _loc6_.name;
            var _loc5_ = new Date(Number(_loc3_[1]) * com.clubpenguin.stamps.StampManager.MILLISECONDS);
            var _loc2_ = this.shell.getLocalizedString("pin_release_date");
            var _loc8_ = Number(_loc3_[2]) != 1?false:true;
            _loc2_ = com.clubpenguin.util.StringUtils.replaceString("%month%",com.clubpenguin.stamps.StampManager.MONTH_STRING[_loc5_.getMonth()],_loc2_);
            _loc2_ = com.clubpenguin.util.StringUtils.replaceString("%day%",String(_loc5_.getDate()),_loc2_);
            _loc2_ = com.clubpenguin.util.StringUtils.replaceString("%year%",String(_loc5_.getFullYear()),_loc2_);
            _loc10_.push(new com.clubpenguin.stamps.PinItem(_loc7_,_loc9_,_loc2_,_loc8_));
         }
         _loc4_ = _loc4_ + 1;
      }
      var _loc13_ = new com.clubpenguin.stamps.StampBookCategory(com.clubpenguin.stamps.StampManager.PIN_CATEGORY_ID,this.pinCategoryName,[],_loc10_,[]);
      this._usersStampCategories = this.clubPenguinStampCategories.concat(_loc13_);
      var _loc14_ = new com.clubpenguin.stamps.StampBookCategory(com.clubpenguin.stamps.StampManager.MYSTERY_CATEGORY_ID,com.clubpenguin.stamps.StampManager.MYSTERY_PAGE_TITLE,[],[],[]);
      this._usersStampCategories.push(_loc14_);
      this.shell.updateListeners(this.shell.PLAYERS_STAMP_BOOK_CATEGORIES,this._usersStampCategories);
   }
   function handleGetPlayersStamps(serverEventData)
   {
      var _loc4_ = Number(serverEventData.shift());
      var _loc2_ = Number(serverEventData.shift());
      this._activeUsersStampList = this.createStampBookItemListFromServerData(serverEventData,com.clubpenguin.stamps.StampBookItemType.STAMP.__get__value());
      if(this.shell.isMyPlayer(_loc2_))
      {
         this._myStamps = this._activeUsersStampList;
      }
      this.awardsService.queryPlayersAwards(_loc2_);
   }
   function handleQueryPlayersAwards(serverEventData)
   {
      var _loc8_ = Number(serverEventData.shift());
      var _loc6_ = Number(serverEventData.shift());
      var _loc5_ = serverEventData[0].split(com.clubpenguin.stamps.StampManager.SOCKET_SERVER_DATA_DELIMITER);
      var _loc4_ = _loc5_.length;
      var _loc7_ = undefined;
      serverEventData[0] = "";
      var _loc2_ = 0;
      while(_loc2_ < _loc4_)
      {
         serverEventData[0] = serverEventData[0] + this.getAwardStampID(_loc5_[_loc2_]);
         if(_loc2_ < _loc4_ - 1)
         {
            serverEventData[0] = serverEventData[0] + com.clubpenguin.stamps.StampManager.SOCKET_SERVER_DATA_DELIMITER;
         }
         _loc2_ = _loc2_ + 1;
      }
      _loc7_ = this.createStampBookItemListFromServerData(serverEventData,com.clubpenguin.stamps.StampBookItemType.AWARD.__get__value());
      this._activeUsersStampList = this._activeUsersStampList.concat(_loc7_);
      if(this.shell.isMyPlayer(_loc6_))
      {
         this._myStamps = this._activeUsersStampList;
      }
      this.shell.updateListeners(this.shell.PLAYERS_STAMPS,this._activeUsersStampList);
   }
   function handleGetMyRecentlyEarnedStamps(serverEventData)
   {
      var _loc3_ = Number(serverEventData.shift());
      this.shell.updateListeners(this.shell.MY_RECENTLY_EARNED_STAMPS,this.createStampBookItemListFromServerData(serverEventData,com.clubpenguin.stamps.StampBookItemType.STAMP.__get__value()));
   }
   function handleGetStampBookCoverDetails(serverEventData)
   {
      var _loc14_ = Number(serverEventData.shift());
      var _loc10_ = Number(serverEventData.shift());
      var _loc9_ = Number(serverEventData.shift());
      var _loc11_ = Number(serverEventData.shift());
      var _loc13_ = Number(serverEventData.shift());
      var _loc12_ = undefined;
      var _loc7_ = [];
      var _loc8_ = serverEventData.length;
      var _loc3_ = 0;
      while(_loc3_ < _loc8_)
      {
         var _loc2_ = serverEventData[_loc3_].split(com.clubpenguin.stamps.StampManager.SOCKET_SERVER_DATA_DELIMITER);
         var _loc4_ = undefined;
         if(_loc2_[0] == com.clubpenguin.stamps.StampBookItemType.AWARD.__get__value())
         {
            _loc2_[1] = this.getAwardStampID(_loc2_[1]);
         }
         _loc4_ = this.getStampBookItem(_loc2_[1],_loc2_[0]);
         if(_loc4_ != undefined)
         {
            var _loc5_ = new com.clubpenguin.stamps.StampBookCoverItem(_loc4_,new flash.geom.Point(_loc2_[2],_loc2_[3]),_loc2_[4],_loc2_[5]);
            _loc7_.push(_loc5_);
         }
         _loc3_ = _loc3_ + 1;
      }
      _loc12_ = new com.clubpenguin.stamps.StampBookCover(_loc7_,_loc10_,_loc9_,_loc11_,_loc13_);
      this.shell.updateListeners(this.shell.STAMP_BOOK_COVER_DETAILS,_loc12_);
   }
   function handlePlayerEarnedStampReceived(serverEventData)
   {
      var _loc4_ = Number(serverEventData[0]);
      var _loc2_ = Number(serverEventData[1]);
      this.shell.stampEarned(_loc2_,true);
   }
   function handleStampDefinitionsParsed(clubPenguinStampCategories, numClubPenguinStamps)
   {
      if(clubPenguinStampCategories != undefined)
      {
         this.clubPenguinStampCategories = clubPenguinStampCategories;
         this._usersStampCategories = clubPenguinStampCategories;
         this._numClubPenguinStamps = numClubPenguinStamps;
      }
   }
   function findStampBookItemInItemsList(id, items, typeValue)
   {
      if(items != undefined)
      {
         var _loc3_ = items.length;
         var _loc1_ = 0;
         while(_loc1_ < _loc3_)
         {
            if(items[_loc1_].getType().value == typeValue && items[_loc1_].getID() == id)
            {
               return items[_loc1_];
            }
            _loc1_ = _loc1_ + 1;
         }
      }
      return undefined;
   }
   function createStampBookItemListFromServerData(serverEventData, typeValue)
   {
      var _loc4_ = [];
      var _loc5_ = serverEventData[0].split(com.clubpenguin.stamps.StampManager.SOCKET_SERVER_DATA_DELIMITER);
      var _loc6_ = _loc5_.length;
      var _loc2_ = 0;
      while(_loc2_ < _loc6_)
      {
         var _loc3_ = this.getStampBookItem(_loc5_[_loc2_],typeValue);
         if(_loc3_ != undefined)
         {
            _loc4_.push(_loc3_);
         }
         _loc2_ = _loc2_ + 1;
      }
      return _loc4_;
   }
   function getHasModifiedStampCover()
   {
      return this._hasModifiedStampCover;
   }
   function setHasModifiedStampCover(hasModifiedStampCover)
   {
      this._hasModifiedStampCover = hasModifiedStampCover;
   }
}
