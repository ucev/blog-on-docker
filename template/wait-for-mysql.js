const mysql = require('promise-mysql')
const process = require('process')
const { spawn } = require('child_process')


function connectmysql() {
    return new Promise((resolve, reject) => {
        function __conn() {
            mysql.createConnection({
                host: 'mysql',
                user: 'root',
                password: 'MY_MYSQL_PASS'
            }).then(() => {
                console.log('MySQL is up')
                return resolve()
            }).catch((err) => {
                console.log('MySQL is unavailable')
                setTimeout(__conn, 1000)
            })            
        }
        __conn()
    })
}

async function runChildProcess() {
    const argv = process.argv.slice(2)
    if (argv.length == 0) {
        return
    }
    let cprocess
    if (argv.length == 1) {
        cprocess = spawn(argv[0])
    } else {
        cprocess = spawn(argv[0], argv.slice(1))
    }
    return new Promise((resolve, reject) => {
        cprocess.stdout.on('data', (data) => {
            console.log(`${argv[0]} -- ${data}`)
        })
        cprocess.stderr.on('data', (data) => {
            console.log(`${argv[0]} -- ${data}`)
        })
        cprocess.on('close', () => {
            resolve()
        })
        cprocess.on('error', () => {
            reject()
        })
    })
}
console.log(process.argv)

connectmysql().then(() => {
    return runChildProcess()
}).then(() => {
    // spawn('npm', ['start'])
    console.log('--------- end ---------')
})
