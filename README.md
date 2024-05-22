    - name: Deploy with server
      uses: saranraj3195/deployment-command@main
      with:
        DEPLOY_KEY: ${{ secrets.DEPLOY_KEY }}
        USERNAME: your-username
        SERVER_IP: your-server-ip
        SERVER_DESTINATION: /path/to/deploy
        ARGS: -avz
        SERVER_PORT: 22
        FOLDER: your-folder
        SCRIPT: |
          whoami
          ls -al
