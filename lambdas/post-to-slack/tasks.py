from invoke import task


@task
def deploy(c):
    c.run("docker build -t andyhuynh/post-to-slack:latest .")