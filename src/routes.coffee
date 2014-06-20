module.exports =
  getUser:
    endpoint: "/me"
    method: "GET"
    description: "Provides information about the signed in user."
  getRecentProjects:
    alias: "getProjects"
    endpoint: "/projects"
    method: "GET"
    description: "List of all the projects you're following on CircleCI, with build information organized by branch."
    options: ['limit', 'offset']
  getProject:
    endpoint: "/project/:username/:project"
    method: "GET"
    description: "Build summary for each of the last 30 builds for a single git repo."
  getRecentBuilds:
    alias: "getBuilds"
    method: "GET"
    endpoint: "/recent-builds"
    description: "Build summary for each of the last 30 recent builds, ordered by build_num."
    options: ['limit', 'offset']
  getBuild:
    endpoint: "/project/:username/:project/:build_num"
    method: "GET"
    description: "Full details for a single build. The response includes all of the fields from the build summary. This is also the payload for the notification webhooks, in which case this object is the value to a key named 'payload'."
  startBuild:
    endpoint: "/project/:username/:project/tree/:branch"
    method: "POST"
    description: "Triggers a new build, returns a summary of the build. Optional build parameters can be set using an experimental API."
  cancelBuild:
    endpoint: "/project/:username/:project/:build_num/cancel"
    method: "POST"
    description: "Cancels the build, returns a summary of the build."
  retryBuild:
    endpoint: "/project/:username/:project/:build_num/retry"
    method: "POST"
    description: "Retries the build, returns a summary of the new build."
  getBuildArtifacts:
    endpoint: "/project/:username/:project/:build_num/artifacts"
    method: "GET"
    description: "List the artifacts produced by a given build."
  clearBuildCache:
    endpoint: "/project/:username/:project/build-cache"
    method: "DELETE"
    description: "Clears the cache for a project"
  addSSHKey:
    endpoint: "/user/ssh-key"
    method: "POST"
    description: "Adds a CircleCI key to your Github User account."
  addHerokuKey:
    endpoint: "/user/heroku-key"
    method: "POST"
    description: "Adds your Heroku API key to CircleCI, takes apikey as form param name."