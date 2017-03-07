swagger: '2.0'
info:
  title: Sex Me Up
  description: 企业站发布接口
  version: "1.0.0"
host: {$host}
schemes:
  - http
basePath: /admin
consumes:
  - application/x-www-form-urlencoded
produces:
  - application/json
paths:
  /sexmeup.php:
    post:
      summary: 发布产品接口
      description: |
        发布产品（含图片）。
      parameters:
        - name: pw
          in: query
          description: 通讯密码
          required: true
          type: string
        - name: remotePic
          in: formData
          description: 用三竖线（|||）分割的图片URL
          required: false
          type: string
        - name: title
          in: formData
          description: 产品标题
          required: false
          type: string
        - name: content
          in: formData
          description: 产品描述
          required: false
          type: string
        - name: brand
          in: formData
          description: 品牌名称
          required: false
          type: string
        - name: minamount
          in: formData
          description: 起订量
          required: false
          type: string
        - name: price
          in: formData
          description: 价格
          required: false
          type: string
        - name: amount
          in: formData
          description: 库存（供货能力）
          required: false
          type: string
        - name: days
          in: formData
          description: 运输时间（供货周期）
          required: false
          type: string
        - name: n1
          in: formData
          description: 属性1名称
          required: false
          type: string
        - name: v1
          in: formData
          description: 属性1值
          required: false
          type: string
        - name: n2
          in: formData
          description: 属性2名称
          required: false
          type: string
        - name: v2
          in: formData
          description: 属性2值
          required: false
          type: string
        - name: n3
          in: formData
          description: 属性3名称
          required: false
          type: string
        - name: v3
          in: formData
          description: 属性3值
          required: false
          type: string
      tags:
        - 产品接口
      responses:
        200:
          description: 产品ID
          schema:
            type: integer
            format: int64
        default:
          description: 出现错误
          schema:
            $ref: '#/definitions/Error'
  /blowjob/lick.php:
    put:
      summary: 更新任务进度接口
      description: |
        更新指定任务的进度和状态。
      parameters:
        - name: pw
          in: formData
          description: 通讯密码
          required: true
          type: string
      tags:
        - 任务接口
      responses:
        200:
          description: 更新成功
          schema:
            $ref: '#/definitions/Error'
        default:
          description: 出现错误
          schema:
            $ref: '#/definitions/Error'
definitions:
  Error:
    properties:
      code:
        type: integer
        format: int32
      message:
        type: string
