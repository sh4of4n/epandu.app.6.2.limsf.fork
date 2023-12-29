30/12/2023 V.6.2.11
WS 6.2.211

- Removed logoutUserRoom function after logout from app it will solve double tick issue for below scenario. Currently app showing double tick suppose to show single tick.
  Consider 3 Users (UserA, UserB, UserC) in group chat.
  Step 1: UserB logout from the app and socket. But still, he is a member of the room.
  Step 2: UserA sends a message.
  Step 3: UserC read that message and updates to UserA.

26/12/2023 V.6.2.11
WS 6.2.211

- Enhanced room list room names start with uppercase letter & removed left side margin of image icon.
- Enhanced room members member names start with uppercase letter.

20/12/2023 V.6.2.11
WS 6.2.211

- Enhanced chat repository WS call error messages text.

19/12/2023 V.6.2.11
WS 6.2.211

- Chat message sent/received date time included year for all message types.
- Resolved chat room batch by batch load chat history for below scenario.
  If chat room contains only text messages of 1st batch then it's loading second batch. After 2nd batch next batches not loading even though data exist in database. After i change to batch size count=50 then problem resolved.
- Enhanced chat room to segregate chathistory based on date.

18/12/2023 V.6.2.11
WS 6.2.211

- Image card enhanced in chat_files.dart screen to show full image same like chat room.

15/12/2023 V.6.2.11
WS 6.2.211

- Resolved font size issue compare to whatsapp.
- Message card width must show based on message length.
- Image card enhanced same like whatsapp.
- Resolved padding issues in between all the message types.

13/12/2023 V.6.2.11
WS 6.2.211

- While searching for the keyword in chat room, the text color for other members was changed from black to white, and the issue has been resolved.

11/12/2023 V.6.2.11
WS 6.2.211

- Resolved issue chat room history showing reverse order with flashing effect finally showing correct message order.

08/12/2023 V.6.2.11
WS 6.2.211

- Resolved issue if userA invite userB and navigate to room list screen then userB send message to userA.
  Roomlist screen not show badge count.

04/12/2023 V.6.2.11
WS 6.2.211

- Updated socketclicnet_helper file if wifi turn of and on using socket.reconnect event to login to rooms and stoppd socket.onany function.

30/11/2023 V.6.2.11
WS 6.2.211

- Enhanced database_helper dart file if add new column to table change database version and add alter command in upgrade function.

29/11/2023 V.6.2.11
WS 6.2.211

- Enhanced search function on to search text changed event and highlight the search word with background color.
- Enhanced logoutUserRoom() function by adding future.

24/11/2023 V.6.2.11
WS 6.2.211

- Resolved sequence issue if wifi disconnect and connect back for below scenario.
  Step 1: Already send 1,2,3 message sent success.
  Step 2: Turnoff wifi and send message 3,4,5.
  Step 3: Exit chat room and come back then 3,4,5 showing above the 1st message.
  To resolve this issue i get failed messages send datetime ascending order and check list of all messages in chat room compare with client id if not exist adding and if exist then remove it add below the list . So all failed messages will show below the chat room.
- Added new function to remove IOS badge icon count value.

  23/11/2023 V.6.2.11
  WS 6.2.211

- Resolved issue in room list screen null check operator used on null value for deleted propertie in Room class.

22/11/2023 V.6.2.11
WS 6.2.211

- Resolved issue for below scenario if userA login no chat with any friend then logout. If userB login same device userA rooms also showing. To avoid this i am added owner_id(UserId) column in roomTable in database table. While login compare this value delete previous login user data from database and directory.

21/11/2023 V.6.2.11
WS 6.2.211

- Resolved issue like below scenario if userA offline and userB left the Group Chat. When user open back the app latest message showing as some filepath without extention due to not checking bainary!='' condtion it's creating file path. If file path room exist room list show the file name as latest message.
- Resolved another issue which is UserA added UserB then app store that message in local db and sendout message to other room members. While storing in Local mobile db messageId storing as 0. Then message showing at the top. For this i am updating messageId after acknowledgement from send message success.

20/11/2023 V.6.2.11
WS 6.2.211

-Enhanced the room list screen so that members can delete private chat rooms logically from database but connect to socket to receive messages.

16/11/2023 V.6.2.11
WS 6.2.211

-Enhanced the room list screen so that members cannot leave chat support and private chat rooms but can leave group chat rooms.

- Resolved message sequence issue if wifi turn off and on based on server message id and delayed 1 second after resend of every message.

14/11/2023 V.6.2.11
WS 6.2.211

- Resolved issue NoSuchMethodError: Class 'List<dynamic>' has no instance method 'containsKey'.
  Receiver: Instance(length:0) of '\_GrowableList'
  Tried calling: containsKey("error") in socket on users event.

10/11/2023 V.6.2.11
WS 6.2.211

- Enhanced all the chat relates WS response if contains null then convert to empty string.
- Fixed FormatException: Invalid date format i chat room send message event.

09/11/2023 V.6.2.11
WS 6.2.211

- Resolved Null check operator used on a null value issues in Chatroom and AudioCard screen.
- Resolved Null check operator used on a null value issues room members screen if nick name null came.

07/11/2023 V.6.2.11
WS 6.2.211

- Resolved issue with below scenario
  if userA changed the group name we are notifying to all the room members then notification came to this userA also then roomlist showing notification badge as 1.
- Update nickName from update profile screen then inform to all the room members he/she exists then update into the room member table nick name column.
- Removed the function update room name if member/admin update the IC/passport name from update profile screen.

06/11/2023 V.6.2.11
WS 6.2.211

- Enhanced if member update profile IC/Passport name notify to other room members and show the room name as update name.
- Enhanced change group name popup to show current room name and title modified to Change group name.

03/11/2023 V.6.2.11
WS 6.2.211

- Enhanced generateRandomString() function due to if 0 available in front of client messageId socket server side unable to store.
- Resolved message sequence issue if wifi turn off and on by storing server time in db while send and receive time.

02/11/2023 V.6.2.11
WS 6.2.211

- Cleared mobile notification when user open the room list screen.
- Enhanced unread messages count issue.

01/11/2023 V.6.2.11
WS 6.2.211

- Resolved range error issue in ChatHistory.updateChatItemStatus function.
- Enhanced today chat messages time to show Today, Time AM/PM.
- Enhanced loginUser() function to speed up the performance.

26/10/2023 V.6.2.11
WS 6.2.211

- Chat room add new friend success navigation issue resolved
- Message status icon issue resolved while getting offline messages from socket server.
- Audio player PlatformException resolved in ChatFiles,ConfirmAudio screens.
- Fixed Record video issue in android version8
- The Scrollbar's ScrollController has no ScrollPosition attached issue fixed.
- File not found exception
- Permission exception (A request for permissions is already running, please wait for it to finish before doing another request .)
- Audio player PlatformException.
- resolved receive message issue for below scenario
  Member A got two phone , iphone and samsung.
  login same carser member account.
  iphone send message. but samsung cannot see the message .
- Resolved Typing issue .(Showing user typing if other side stop typing)
- Null check operator used on a null value issue fixed in ChatRoom, RoomList screens
- Removed Removed Invalid use of a private type in a public API warnings
- Cleared the non_constant_identifier_names warning.
- Bug fixes regarding search function,chat room image not showing issue, icon alignments.
- Bug fixes regarding search function, Video duplication, record video function in tab version
- Show chat history batch by batch
- Fixed bugs regarding duplicate messages
- Bug fixes in roomlist must show latest message when nitification came.
- Video files enhancments
- Fixed Duplicate media issues
- Bug fixes in roomlist must show latest message when nitification came.
- Video files enhancments
- Bug fixes regarding roomName.
- Replaced createChatSupport WS to createChatSupportByMember
- Enhanced typing events to show typing animation in correct rooms
- Fixed bugs.
- Chat screen video card enhancements

06/06/2023 V.6.1.11
WS 6.1.211

- Show the merchant name chat room page
- Show the merchant banner beside room name on chat room page
- Show the default Carser merchant at the top of the room list correct fallowed by latest chat rooms.
- Ledger color scheme to rooms in room list page

02/06/2023 V.6.1.10
WS 6.1.211

- Chatting - Creating room with ePandu and with merchant. - Creating room on the selected merchant. - Creating room when register a merchant

01/06/2023 V.6.1.9
WS 6.1.210

- Chatting
- Webview on IM - able to call IM, navigate to Map, Able to chat on IM.

28/02/2023 V.6.1.7

- Bugs Fixed and enhancements

28/02/2023 V.6.1.6

- Added Chat Features(Text,Audio,Video,Images)
