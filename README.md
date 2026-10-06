# LMS Blue-Green Deployment

## Objective

Deploy a new LMS version without interrupting students currently using the application.

## Architecture

Students
   |
   v
Nginx :80
   |
   +---- Blue :8080
   |
   +---- Green :8081

## Blue Environment

Blue runs the current LMS version on port 8080.

## Green Environment

Green runs the new LMS version on port 8081.

## Deployment Flow

1. Deploy the current version to Blue.
2. Deploy the new version to Green.
3. Test Green health endpoint.
4. Switch Nginx traffic from Blue to Green.
5. Monitor the new version.
6. Roll back to Blue if any issue occurs.

## Health Check

curl http://localhost:8080/health

curl http://localhost:8081/health

## Switch to Green

./scripts/switch-to-green.sh

## Rollback to Blue

./scripts/rollback-to-blue.sh

## Troubleshooting

Check Blue:

sudo systemctl status lms-blue

Check Green:

sudo systemctl status lms-green

Check Nginx:

sudo nginx -t

Check Nginx logs:

sudo tail -f /var/log/nginx/error.log

Check application logs:

sudo journalctl -u lms-blue -f

sudo journalctl -u lms-green -f
