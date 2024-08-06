### Create Repository and Folder

1. **Create a Repository:**
   - Create a public repository named `slackbot` on your GitHub account.

2. **Set Up Local Folder:**
   - Create a local folder named `slackbot`.

3. **Initialize Git:**
   - Navigate to the `slackbot` folder and run:
     ```bash
     git init
     ```

4. **Link to Remote Repository:**
   - Connect your local Git repository to the remote GitHub repository with:
     ```bash
     git remote add origin https://github.com/your-username/slackbot.git
     ```

### Creating Slack Channel, Webhook, and Establishing Connection

5. **Create a Slack Channel:**
   - In Slack, create a new channel named `kubernetes`.

6. **Create a Slack App:**
   - Use this [link](https://api.slack.com/apps) to create a Slack App. Name it `slackbotcd` (avoid using `slackbot` as it is a reserved name). Select your workspace where the `kubernetes` channel is located.

7. **Set Up Incoming Webhooks:**
   - Enable Incoming Webhooks and add a new webhook for the `kubernetes` channel. Copy the webhook URL and use it to post a test message to the channel using `curl`. Check the `kubernetes` channel to confirm the message appears.

8. **Enable Event Subscriptions:**
   - Go to Event Subscriptions and activate events to allow the bot to listen to channel activities.

9. **Expose Your Slackbot:**
   - Install `npm` if not already installed:
     ```bash
     brew install npm-check-updates
     ```
   - Verify the installation with `npm -v`. Then install `ngrok`:
     ```bash
     npm install -g ngrok
     ```

10. **Configure ngrok:**
    - Create an account at [ngrok](https://ngrok.com/) and add your authtoken to the `ngrok.yml` configuration file:
      ```bash
      ngrok config add-authtoken your-token
      ```

11. **Run ngrok:**
    - Start `ngrok` to expose your local server:
      ```bash
      ngrok http 3000
      ```
    - Copy the provided HTTPS link (e.g., `https://<...>.ngrok-free.app`).

12. **Update Slack Event Subscriptions:**
    - Paste the copied HTTPS link into the Slack Event Subscriptions - Enable Events - Request URL field. You may see an error; this is expected until your Slackbot is fully functional.

### Creating the Bot

13. **Initialize the Bot:**
    - In the `slackbot` folder, run:
      ```bash
      npm init
      ```
    - Provide the following details:
      - **package name:** slackbot
      - **version:** 1.0.0
      - **description:** Slack Bot
      - **entry point:** app.js
      - **test command:** npm test
      - **git repository:** https://github.com/your-username/slackbot.git
      - **keywords:** slackbot
      - **author:** Nurbol Mendybayev
      - **license:** ISC

14. **Create `package.json`:**
    - This will generate the `package.json` file in the `slackbot` folder.

15. **Create the Bot Script:**
    - In the `slackbot` folder, create an `app.js` file.

16. **Install Required Packages:**
    - Install the package to handle Slack events:
      ```bash
      npm install @slack/events-api
      ```
    - Install the package to post messages:
      ```bash
      npm install @slack/web-api
      ```

17. **Set Up Environment Variables:**
    - Define your Slack credentials:
      ```bash
      export SLACK_SIGNING_SECRET=your-signing-secret
      export SLACK_TOKEN=your-bot-user-oauth-token
      ```

18. **Configure OAuth & Permissions:**
    - Add OAuth scopes: `app_mentions:read`, `chat:write`.
    - Reinstall your app and set the bot to post in the `kubernetes` channel.

19. **Run the Bot:**
    - Execute your bot:
      ```bash
      node app.js
      ```
    - You should see the message: "Server started on port 3000".

20. **Update Slack Event Subscriptions URL:**
    - Append `/slack/events` to the previously copied HTTPS link and update Slack Event Subscriptions - Enable Events - Request URL field. The status should now be "verified". Add `app_mention` under "Subscribe to bot events" and save changes.

21. **Test the Bot:**
    - In the `kubernetes` channel, type: `Hello, @slackbotcd`. Send the message and invite the bot. Send another message: `Hello, @slackbotcd`. The bot should respond with: "Hello @Nurbol Mendybayev! :tada:"

### **The End**

![Completion Image](tada.png)

### help:

* **Updating the URL:**
  1. Run `ngrok http 3000` to re-establish the connection and copy the new HTTPS link (e.g., `https://....ngrok-free.app`).
  2. Paste the updated HTTPS link into [Slack API Event Subscriptions](https://api.slack.com/) - Enable Events - Request URL field and save.

* **Finding Credentials:**
  - **TOKEN:** Go to [Slack API](https://api.slack.com/) - Install App - OAuth Tokens for Your Workspace.
  - **SLACK_SIGNING_SECRET:** Go to [Slack API](https://api.slack.com/) - Basic Information - Signing Secret.
