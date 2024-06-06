// 引入所需的模块
const http = require('http');
const os = require('os');

// 创建服务器
const server = http.createServer((req, res) => {
  // 设置响应头，指定返回的内容类型为 JSON
  res.setHeader('Content-Type', 'application/json');

  // 根据不同的路径返回不同的 JSON 数据
  if (req.url === '/hello') {
    const responseData = {
      message: 'Hello, world!',
      tasks: ['😊任务一','task2','😊任务3'],
      totalPages:5
    };
    res.end(JSON.stringify(responseData));
  } else if (req.url === '/goodbye') {
    const responseData = {
      message: 'Goodbye, world!',
      timestamp: new Date().toISOString()
    };
    res.end(JSON.stringify(responseData));
  } else {
    // 如果请求的路径不是 '/hello' 或 '/goodbye'，返回 404 Not Found 错误
    res.statusCode = 404;
    res.end(JSON.stringify({ error: 'Not Found' }));
  }
});

// 获取局域网 IP 地址
function getLocalIPAddress() {
  const ifaces = os.networkInterfaces();
  for (const iface of Object.values(ifaces)) {
    for (const alias of iface) {
      if (alias.family === 'IPv4' && !alias.internal) {
        return alias.address;
      }
    }
  }
}

// 监听端口
const PORT = 3000;
server.listen(PORT, () => {
  const localIPAddress = getLocalIPAddress();
  console.log(`Server is running at http://${localIPAddress}:${PORT}`);
});
