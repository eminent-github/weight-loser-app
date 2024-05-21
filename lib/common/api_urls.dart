class ApiUrls {
  static const String baseUrl = "https://weightloser.com/api";
  // static const String baseUrl = "https://weightloser.somee.com";
  static const String imageBaseUrl = "$baseUrl/StaticFiles/images/";
  static const String s3ImageBaseUrl = "${s3BucketBaseUrl}Images/";
  static const String videoBaseUrl = "$baseUrl/StaticFiles/Videos/";
  static const String s3VideoAudioBaseUrl = "${s3BucketBaseUrl}Vedios/";
  static const String s3BucketBaseUrl = "https://weightloser.s3.amazonaws.com/";
  static const String signUpEndPoint = "/api/Account/SignUp";
  static const String logInEndPoint = "/api/Account";
  static const String verifyOtpEndPoint = "/api/Account/VerifyOTP";
  static const String verifyEmailEndPoint = "/api/Account/EmailVerify";
  static const String resendOtpEndPoint = "/api/OTP/GetOtpAgain";
  static const String genderEndPoint = "/api/User/Gender";
  static const String ageEndPoint = "/api/User/Age";
  static const String heightEndPoint = "/api/User/Height";
  static const String weightEndPoint = "/api/User/Weight";
  static const String targetWeightEndPoint = "/api/User/TargetWeight";
  static const String pregnentEndPoint = "/api/User/Pregnent";
  static const String reasonLossWeightEndPoint = "/api/User/ReasontoLossWeight";
  static const String targetDateEndPoint = "/api/User/TargetDate";
  static const String getQuestionWithAnswer =
      "/api/Question/GetQuestionWithAnswer";
  static const String postQuestionsAnswerEndPoint = "/api/QuestionAnswer";
  static const String forgotPasswordEndPoint = "/api/User/ForgetPassword";
  static const String userReviewEndPoint = "/api/User/Review";
  static const String getPopularPlansEndPoint = "/api/Plan/GetPlans";
  static const String activatePlanEndPoint = "/api/ActivePlan";
  static const String userActivePlansEndPoint = "/api/ActivePlan/UserDietPlans";
  static const String foodPlanDetailEndPoint = "/api/Plan/FoodPlan";
  static const String exercisePlanDetailEndPoint = "/api/Plan/ExercisePlanApp";
  static const String mindPlanDetailEndPoint = "/api/Plan/MindPlan";
  static const String foodDetailEndPoint = "/api/Food/getfooddetailbyid";
  static const String addMealEndPoint = '/api/ActivePlan/AddMeal';
  static const String foodReplacementEndPoint =
      '/api/ActivePlan/FoodReplacement';
  static const String favouriteEndPoint = '/api/Favourite/Post';
  static const String userActivePlanForExercises =
      '/api/ActivePlan/UserExercisePlans';
  static const String userActivePlanForMind = '/api/ActivePlan/UserMindPlans';
  static const String updateExerciseTime = '/api/Exercise/History';
  static const String updateMindTime = '/api/Exercise/MindHistory';
  static const String saveTodayDiet = '/api/diary';
  static const String editTodayDiet = '/api/diary/UpdateWater';
  static const String getTodayDiaryInfo = '/api/Diary/GetById';
  static const String homePageTodayQuota = '/api/ActivePlan/Today';
  static const String homePageTodayBudget = '/api/ActivePlan/TodayBudget';
  static const String homePageTodayCBT = '/api/ActivePlan/TodayCBT';
  static const String homePageTodayMeditation = '/api/ActivePlan/TodayMindVideos';
  static const String homePageTodayTodo = '/api/ActivePlan/TodayTodo';
  static const String homePageTodayExercise = '/api/ActivePlan/TodayExerciseVideos';
  static const String homePageTodayFood = '/api/ActivePlan/TodayFood';
  static const String getWaterInfo = '/api/diary/GetWaterInTake';
  static const String userRecipeEndPoint = '/api/UserRecipe/GetRescipeByUser';
  static const String addNewRecipeEndPoint = '/api/Food/Recipe';
  static const String searchIngredientsEndPoint = '/api/Food/SearchFood';
  static const String discoverRecipeEndPoint = '/api/UserRecipe/GetRescipe';
  static const String communityChatPostEndPoint = '/api/ChatPost';
  static const String communityChatPostFilesEndPoint = '/api/ChatFiles';
  static const String communityPostImageEndPoint = '/api/File/SaveImage';
  static const String communitySavedPostsEndPoint =
      '/api/ChatSave/GetAllSavedChatsByUser';
  static const String communityAllPostsEndPoint = '/api/ChatPost/GetAllChats';
  static const String communityAllPostsbyUserEndPoint =
      '/api/ChatPost/GetAllChatsByUser';
  static const String savePostEndPoint = '/api/ChatSave';
  static const String likePostEndPoint = '/api/ChatDetail';
  static const String deletePostEndPoint = '/api/ChatPost';
  static const String getUserProfileEndPoint = '/api/UserProfile/GetByUserId';
  static const String getUserCommentsEndPoint =
      '/api/Chatdetail/GetCommentsByChatId';
  static const String getSavedDetialEndPoint =
      '/api/ChatSave/GetSavedChatsByUser/';
  static const String postUserProfileEndPoint = '/api/UserProfile';
  static const String getUserEmailEndPoint = '/api/Account/GetUserEmail';
  static const String deleteUserAccountEndPoint = '/api/Account/AccountDelete';
  static const String logoutAccountEndPoint = '/api/Account/LogOut';
  static const String getUltimateSelfieEndPoint = '/api/Selfie';
  static const String getDeepSleepEndPoint = '/api/Sleep/GetByDate';
  static const String postDeepSleepEndPoint = '/api/Sleep/Post';
  static const String postCheatFoodEndPoint = '/api/CheatFood';
  static const String getCheatFoodEndPoint = '/api/CheatFood/GetByUserId';
  static const String getGroceryEndPoint = '/api/ActivePlan/GroceryList';
  static const String groceryPurchasedEndPoint = '/api/ActivePlan/Grocery';
  static const String getFavouriteEndPoint =
      '/api/Favourite/GetUserFavouriteByType';
  static const String deleteFavouriteEndPoint = '/api/Favourite/Delete';
  static const String getSubDietFavouriteEndPoint =
      '/api/Favourite/GetUserFavouriteSubType';
  static const String getUserPasswordEndPoint = '/api/user/getuserbyid';
  static const String takingOathEndPoint = '/api/User/OathTaken';
  static const String getPreviousQusEndPoint =
      '/api/Question/GetUserQuestionOrder';
  static const String socialLoginEndPoint = '/api/Account/Other';
  static const String getCbtQuestionsEndPoint = '/api/Cbt/GetCBTByCatagory';
  static const String cbtAnsEndPoint = '/api/QuestionAnswer/AddCBT';
  static const String getChatForTechnicalSupportEndPoint =
      '/api/TechnicalSupport/GetChatsByUser';
  static const String sendMessageForTechnicalSupportEndPoint =
      '/api/TechnicalSupport';
  static const String getUserWeekStatsEndPoint =
      '/api/Diary/GetUserWeekHistory';
  static const String getUserWeightStatsEndPoint = '/api/Diary/WeightHistory';
  static const String getUserStatsEndPoint = '/api/Diary/GetUserWeekHistory';
  static const String saveUserTodoEndPoint = '/api/TaskDairy';
  static const String homePageExerciseReplacement =
      '/api/ActivePlan/ExerciseReplacement';
  static const String homePageDietReplacement =
      '/api/ActivePlan/GetRescipesAccordingMealType';
  static const String homePageDietSuggessions =
      '/api/ActivePlan/TodayDietSuggestion';
  static const String scanFoodEndPoint =
      'https://world.openfoodfacts.org/api/v0/product/';
  static const String saveScanDietToDatabase = '/api/Food/FoodScanner';
  static const String saveCustomDietToDatabase = '/api/Food/CustomFood';
  static const String dynamicActivatePlan =
      '/api/ActivePlan/ActivePlanAccordingQuestion';
  static const String foodRecipiesEndPoint = '/api/ActivePlan/AllPlanFoods';
  static const String paymentPlansEndPoint = '/api/Packages';
  static const String postPaymentEndPoint = '/api/CustomerPackages';
  static const String recentPaymentEndPoint = '/api/CustomerPackages/Users';
  static const String cancelMembershipEndPoint =
      '/api/CustomerPackages/Cancelled';
}
