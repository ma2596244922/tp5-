swagger: '2.0'
info:
  title: Sex Me Up
  description: 企业站发布接口
  version: "1.0.0"
host: {$host}
schemes:
  - http
basePath: /admin/blowjob
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
          in: formData
          description: 通讯密码
          required: true
          type: string
        - name: group_id
          in: formData
          description: 分组ID
          required: true
          type: integer
          format: int64
        - name: identity
          in: formData
          description: 产品唯一标识
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
        - name: model_number
          in: formData
          description: 型号
          required: false
          type: string
        - name: certification
          in: formData
          description: 认证证书
          required: false
          type: string
        - name: place_of_origin
          in: formData
          description: 原产地
          required: false
          type: string
        - name: minamount
          in: formData
          description: 起订量
          required: false
          type: string
        - name: payment_terms
          in: formData
          description: 付款方式
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
        - name: packaging_details
          in: formData
          description: 常规包装
          required: false
          type: string
        - name: specifications
          in: formData
          description: 用三竖线（|||）和冒号（:）分割的关键词
          required: false
          type: string
        - name: tags
          in: formData
          description: 用三竖线（|||）分割的关键词
          required: false
          type: string
        - name: shopurl
          in: formData
          description: 源站URL
          required: false
          type: string
      tags:
        - 产品接口
      responses:
        200:
          description: 发布成功
          schema:
            allOf: 
              - $ref: '#/definitions/Error'
              - type: object
                properties:
                  product_id: 
                    type: integer
                    format: int64
                    description: 产品ID
        default:
          description: 出现错误
          schema:
            $ref: '#/definitions/Error'
  /lick.php:
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
        - name: task_id
          in: formData
          description: 任务ID
          required: true
          type: integer
          format: int64
        - name: status
          in: formData
          description: 任务状态（0-待开始；10-进行中；100-已完成）
          required: true
          type: integer
          format: int32
        - name: progress
          in: formData
          description: 当前进度（0-100）
          type: integer
          format: int32
      tags:
        - 任务接口
      responses:
        200:
          description: 通讯成功
          schema:
            $ref: '#/definitions/Error'
definitions:
  Error:
    properties:
      code:
        type: integer
        format: int32
        description: 错误代码（0代表无错误）
      message:
        type: string
        description: 错误描述
