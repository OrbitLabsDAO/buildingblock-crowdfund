ACTION="${1:-github}" # Default to "build" if no parameter is passed
BRANCH="${2:-main}"


if [ "$ACTION" = "origin" ]; then


    #TODO check that the file does not already exist and delete it if it does.
    echo "Moving files to keep them safe"
    # Move entire _source into _site/tmp to preserve structure
    mkdir -p _site/tmp
    mv _source _site/tmp/

    # Ask user for commit message
    read -p "Enter commit message: " COMMITMESSAGE

    # Git operations
    git checkout "$BRANCH"
    git add .
    git commit -m "$COMMITMESSAGE"
    git push "$ACTION" "$BRANCH"

    # Restore _source from _site/tmp/_source
    mv _site/tmp/_source ./_source
    rmdir _site/tmp 2>/dev/null  # Optional cleanup if empty
    
    exit
fi



if [ "$ACTION" = "github" ]; then

    # Ask for commit message
    read -p "Enter commit message: " COMMITMESSAGE
    echo "Doing the all the git things"
    # Git operations
    git checkout "$BRANCH"
    git add .
    git commit -a -m "$COMMITMESSAGE"
    git push "$ACTION" "$BRANCH"
    echo "Done!"
    exit
fi

echo "Unknown remote $ACTION"