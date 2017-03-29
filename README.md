# CircleCI

[![Build Status](https://secure.travis-ci.org/jpstevens/circleci.png?branch=master)](https://travis-ci.org/jpstevens/circleci)
[![Dependencies](https://david-dm.org/jpstevens/circleci.png)](https://david-dm.org/jpstevens/circleci)
![Downloads/month](http://img.shields.io/npm/dm/circleci.svg)

A Node.js API client for [CircleCI](http://circleci.com)

## Installation

```
npm install circleci --save
```

Then, in your project require and instantiate the CircleCI client:

```javascript
var CircleCI = require('circleci');
var ci = new CircleCI({
  auth: "my-auth-token"
});
```
Note that all requests require a valid API token.

#### Options:
- **auth** (String, required)


## Available Methods

### getUser

Provides information about the signed in user.

#### Example Usage

```javascript
ci.getUser().then(function(user){
  console.log(user.login); // e.g. your Github username
});
```

### getProjects

List of all the projects you're following on CircleCI, with build information organized by branch.

#### Example Usage

```javascript
ci.getProjects().then(function(projects){
  for(var i=0; i < projects.length; i++) {
    console.log(projects[i].reponame); // logs the repo name of each project
  }
});
```

### getRecentBuilds

Recent builds across all projects. Returns the build summary for each of the last 30 recent builds, ordered by build_num.

#### Example Usage

```javascript
ci.getRecentBuilds({ limit: 5, offset: 10 })
  .then(function(builds){
    for(var i=0; i < builds.length; i++) {
      console.log(builds[i].build_num); // logs the build number for each project
    }
  });
```

#### Options
- **limit** [optional] - The number of builds to return. Maximum 100, defaults to 30)
- **offset** [optional] - The API returns builds starting from this offset, defaults to 0)

### getBuilds

Recent builds for a single project. Returns the build summary for each of the last 30 builds for a single git repo.

#### Example Usage

```javascript
ci.getBuilds({ username: "jpstevens", project: "circleci" })
  .then(function(builds){
    for(var i=0; i < builds.length; i++) {
      console.log(builds[i].build_num); // logs the build number for each project
    }
  });
```

#### Options
- **username** [required] - The username for the project you wish to look up
- **project** [required] - The project (repo) name you wish to look up
- **limit** [optional] - The number of builds to return. Maximum 100, defaults to 30)
- **offset** [optional] - The API returns builds starting from this offset, defaults to 0)
- **filter** [optional] - Show only successful/failed/running/pending builds

### getBranchBuilds

Recent builds for a single project filtered by a branch name. Returns the build summary for each of the last 30 builds for a single git repo.

#### Example Usage

```javascript
ci.getBranchBuilds({ username: "jpstevens", project: "circleci", branch: "master" })
  .then(function(builds){
    for(var i=0; i < builds.length; i++) {
      console.log(builds[i].build_num); // logs the build number for each project
    }
  });
```

#### Options
- **username** [required] - The username for the project you wish to look up
- **project** [required] - The project (repo) name you wish to look up
- **branch** [required] - The branch name you wish to use as filter
- **limit** [optional] - The number of builds to return. Maximum 100, defaults to 30)
- **offset** [optional] - The API returns builds starting from this offset, defaults to 0)
- **filter** [optional] - Show only successful/failed/running/pending builds

### getBuild

Full details for a single build. The response includes all of the fields from the build summary. This is also the payload for the notification webhooks, in which case this object is the value to a key named 'payload'.

#### Example Usage

```javascript
ci.getBuild({
  username: "jpstevens",
  project: "circleci",
  build_num: 1
}).then(function(build){
  console.log(build);
});
```

#### Options
- **username** [required] - The username for the project you wish to look up
- **project** [required] - The project (repo) name you wish to look up
- **build_num** [required] - CircleCI build number

### startBuild

Triggers a new build, returns a summary of the build.

#### Example Usage

```javascript
ci.startBuild({
  username: "jpstevens",
  project: "circleci",
  branch: "master"
}).then(function(build){
  console.log(build);
});
```

#### Options
- **username** [required] - The username for the project
- **project** [required] - The project (repo) name
- **branch** [required] - The branch you wish to start the build for
- **options** [optional] - Additional parameters you can pass in

#### Example Usage with additional parameters

```javascript
ci.startBuild({
  username: "jpstevens",
  project: "circleci",
  branch: "master",
  body:
    parallel: null
    revision: null
    build_parameters:
      NODE_ENV: "production"
      FOO: "bar"
}).then(function(build){
  console.log(build);
});
```  

### cancelBuild

Cancels the build, returns a summary of the build.

#### Example Usage

```javascript
ci.cancelBuild({
  username: "jpstevens",
  project: "circleci",
  build_num: 1
}).then(function(build){
  console.log(build);
});
```
#### Options
- **username** [required] - The username for the project you wish to look up
- **project** [required] - The project (repo) name you wish to look up
- **build_num** [required] - CircleCI build number

### retryBuild

#### Example Usage

```javascript
ci.retryBuild({
  username: "jpstevens",
  project: "circleci",
  build_num: 1
}).then(function(build){
  console.log(build);
});
```

#### Options
- **username** [required] - The username for the project you wish to look up
- **project** [required] - The project (repo) name you wish to look up
- **build_num** [required] - CircleCI build number

### getBuildArtifacts

List the artifacts produced by a given build.

#### Example Usage

```javascript
ci.getBuildArtifacts({
  username: "jpstevens",
  project: "circleci",
  build_num: 1
}).then(function(artifacts){
  console.log(artifacts); // logs an array of artifacts
});
```

#### Options
- **username** [required] - The username for the project you wish to look up
- **project** [required] - The project (repo) name you wish to look up
- **build_num** [required] - CircleCI build number


### clearBuildCache

Clears the cache for a project

#### Example Usage

```javascript
ci.clearBuildCache({
  username: "jpstevens",
  project: "circleci"
}).then(function(res){
  console.log(res.status); // e.g. "build caches deleted"
});
```

#### Options
- **username** [required] - The username for the project you wish to look up
- **project** [required] - The project (repo) name you wish to look up


### getEnvVars

Get the environment variables for a project

#### Example Usage

```javascript
ci.getEnvVars({
  username: "jpstevens",
  project: "circleci"
}).then(function(envvars){
  console.log(envvars); // logs an array of environment variables
});
```

#### Options
- **username** [required] - The username for the project you wish to look up
- **project** [required] - The project (repo) name you wish to look up


### getEnvVar

Get a single environment variable for a project by name

#### Example Usage

```javascript
ci.getEnvVar({
  username: "jpstevens",
  project: "circleci",
  name: "NPM_TOKEN"
}).then(function(envvar){
  console.log(envvar); // logs an object with the environment variable
});
```

#### Options
- **username** [required] - The username for the project you wish to look up
- **project** [required] - The project (repo) name you wish to look up
- **name** [required] - The name of the environment variable you wish to look up


### setEnvVar

Set a environment variable for a project by name and value

#### Example Usage

```javascript
ci.setEnvVar({
  username: "jpstevens",
  project: "circleci",
  body: {
    name: "NPM_TOKEN",
    value: "123-456-789",
  }
}).then(function(envvar){
  console.log(envvar); // logs an object with the created environment variable
});
```

#### Options
- **username** [required] - The username for the project you wish to add the environment variable to
- **project** [required] - The project (repo) name you wish to add the environment variable to
- **body** [required] - Object with the `name` and the `value` of the environment variable you wish to add to the project

### deleteEnvVar

Delete an environment variable from a project by name

#### Example Usage

```javascript
ci.deleteEnvVar({
  username: "jpstevens",
  project: "circleci",
  name: "NPM_TOKEN"
}).then(function(envvar){
  console.log(envvar); // logs an object with status of the deletion
});
```

#### Options
- **username** [required] - The username for the project you wish to delete the environment variable from
- **project** [required] - The project (repo) name you wish to delete the environment variable from
- **name** [required] - The name of the environment variable you wish to delete from the project


## Change Log

0.1.0 - Initial (stable) release

0.2.0 - Add `getBranchBuilds` method
