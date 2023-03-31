import requests

# Enter your GitLab server URL and access token here
GITLAB_URL = "https://your-gitlab-server.com/api/v4"
ACCESS_TOKEN = "your-access-token-here"

# Enter the GitLab account username for which you want to list private repositories
GITLAB_USERNAME = "your-gitlab-username"

# Make API request to get a list of all GitLab projects
url = f"{GITLAB_URL}/users/{GITLAB_USERNAME}/projects"
headers = {"PRIVATE-TOKEN": ACCESS_TOKEN}
response = requests.get(url, headers=headers)

# Loop through the list of projects and print the name of private repositories
if response.ok:
    projects = response.json()
    for project in projects:
        if project["visibility"] == "private":
            print(project["name"])
else:
    print("Failed to get list of projects.")
