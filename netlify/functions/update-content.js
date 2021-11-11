'use strict';
const octokit = require('@octokit/rest')();


const username = process.env.REPO_UID;
const password = process.env.REPO_PWD;
const reponame = process.env.SITE_REPO;

exports.handler = async (event) => {
  var content = event.content;
  
  if(!content && event.body) {
    var msg = (typeof event.body == "string") ? JSON.parse(event.body) : event.body;
    content = msg.content;
  }
  
  if(content) {
    content = content.trim();
  }
  
  octokit.authenticate({
    type: 'basic',
    username: username,
    password: password
  });
  
  octokit.repos.getContent({
    owner: username,
    repo: reponame,
    path: 'index.html'
  }).then(function(a) {
    octokit.repos.createFile({
      owner: username,
      repo: reponame,
      path: 'index.html',
      message: 'updating file',
      sha: a && a.data ? a.data.sha : null,
      content: Buffer.from("---\r\nlayout: default\r\n---\r\n" + content + "").toString('base64')
    }).then(function(x) {
      return {
        statusCode: 200,
        headers: {
          "Access-Control-Allow-Origin": "*",
          "Content-Type": "application/json"
        },
        body: JSON.stringify({
          message: 'Changes upgraded successfully!',
          input: event,
        }),
      };
    });
  });
};